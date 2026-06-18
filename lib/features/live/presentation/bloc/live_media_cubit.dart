import 'dart:async';
import 'dart:io' show Platform;

import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:eye_rex_us/features/live/presentation/services/live_permissions_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum LiveMediaStatus { idle, initializing, ready, error }

class LiveMediaState extends Equatable {
  const LiveMediaState({
    this.status = LiveMediaStatus.idle,
    this.cameraEnabled = true,
    this.microphoneEnabled = true,
    this.speakerEnabled = true,
    this.previewReady = false,
    this.lensDirection = CameraLensDirection.front,
    this.beautyFilterEnabled = false,
    this.backgroundBlurEnabled = false,
    this.screenSharing = false,
    this.errorMessage,
  });

  final LiveMediaStatus status;
  final bool cameraEnabled;
  final bool microphoneEnabled;
  final bool speakerEnabled;
  final bool previewReady;
  final CameraLensDirection lensDirection;
  final bool beautyFilterEnabled;
  final bool backgroundBlurEnabled;
  final bool screenSharing;
  final String? errorMessage;

  LiveMediaState copyWith({
    LiveMediaStatus? status,
    bool? cameraEnabled,
    bool? microphoneEnabled,
    bool? speakerEnabled,
    bool? previewReady,
    CameraLensDirection? lensDirection,
    bool? beautyFilterEnabled,
    bool? backgroundBlurEnabled,
    bool? screenSharing,
    String? Function()? errorMessage,
  }) {
    return LiveMediaState(
      status: status ?? this.status,
      cameraEnabled: cameraEnabled ?? this.cameraEnabled,
      microphoneEnabled: microphoneEnabled ?? this.microphoneEnabled,
      speakerEnabled: speakerEnabled ?? this.speakerEnabled,
      previewReady: previewReady ?? this.previewReady,
      lensDirection: lensDirection ?? this.lensDirection,
      beautyFilterEnabled: beautyFilterEnabled ?? this.beautyFilterEnabled,
      backgroundBlurEnabled: backgroundBlurEnabled ?? this.backgroundBlurEnabled,
      screenSharing: screenSharing ?? this.screenSharing,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        cameraEnabled,
        microphoneEnabled,
        speakerEnabled,
        previewReady,
        lensDirection,
        beautyFilterEnabled,
        backgroundBlurEnabled,
        screenSharing,
        errorMessage,
      ];
}

/// Per-session camera/mic controller — one instance per live room scope.
class LiveMediaCubit extends Cubit<LiveMediaState> {
  LiveMediaCubit(this._permissionsService) : super(const LiveMediaState());

  final LivePermissionsService _permissionsService;

  CameraController? _controller;
  List<CameraDescription> _cameras = const [];
  Future<void>? _startInFlight;

  CameraController? get previewController => _controller;

  bool get isPreviewInitialized =>
      _controller != null && _controller!.value.isInitialized;

  Future<void> initialize({required bool startCamera}) async {
    if (!startCamera) {
      emit(state.copyWith(status: LiveMediaStatus.idle));
      return;
    }
    await startCameraPreview();
  }

  Future<void> startCameraPreview() {
    final inFlight = _startInFlight;
    if (inFlight != null) return inFlight;

    final task = _startCameraPreview();
    _startInFlight = task;
    return task.whenComplete(() => _startInFlight = null);
  }

  Future<void> _startCameraPreview() async {
    emit(
      state.copyWith(
        status: LiveMediaStatus.initializing,
        cameraEnabled: true,
        previewReady: false,
        errorMessage: () => null,
      ),
    );

    try {
      final cameraPermission =
          await _permissionsService.request(LivePermissionType.camera);
      if (!cameraPermission.granted) {
        emit(
          state.copyWith(
            status: LiveMediaStatus.error,
            cameraEnabled: false,
            previewReady: false,
            errorMessage: () => 'Allow camera access to go live',
          ),
        );
        return;
      }

      await _permissionsService.request(LivePermissionType.microphone);

      _cameras = await availableCameras();
      if (_cameras.isEmpty) {
        emit(
          state.copyWith(
            status: LiveMediaStatus.error,
            cameraEnabled: false,
            previewReady: false,
            errorMessage: () => 'No camera found on this device',
          ),
        );
        return;
      }

      await _bindCamera(
        state.lensDirection,
        enableAudio: state.microphoneEnabled,
      );

      emit(
        state.copyWith(
          status: LiveMediaStatus.ready,
          previewReady: true,
          cameraEnabled: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: LiveMediaStatus.error,
          cameraEnabled: false,
          previewReady: false,
          errorMessage: () => 'Camera failed to start',
        ),
      );
    }
  }

  ImageFormatGroup? get _imageFormatGroup {
    if (kIsWeb) return null;
    if (Platform.isAndroid) return ImageFormatGroup.yuv420;
    if (Platform.isIOS) return ImageFormatGroup.bgra8888;
    return null;
  }

  Future<void> _bindCamera(
    CameraLensDirection lens, {
    bool? enableAudio,
  }) async {
    await _controller?.dispose();
    _controller = null;

    final description = _cameras.firstWhere(
      (c) => c.lensDirection == lens,
      orElse: () => _cameras.first,
    );

    Object? lastError;
    for (final preset in [ResolutionPreset.medium, ResolutionPreset.low]) {
      try {
        final controller = CameraController(
          description,
          preset,
          enableAudio: enableAudio ?? state.microphoneEnabled,
          imageFormatGroup: _imageFormatGroup,
        );
        await controller.initialize();
        _controller = controller;
        return;
      } catch (e) {
        lastError = e;
        await _controller?.dispose();
        _controller = null;
      }
    }

    throw lastError ?? StateError('Camera could not initialize');
  }

  Future<void> toggleCamera() async {
    if (state.cameraEnabled && state.previewReady) {
      await _controller?.dispose();
      _controller = null;
      emit(
        state.copyWith(
          cameraEnabled: false,
          previewReady: false,
          status: LiveMediaStatus.idle,
        ),
      );
      return;
    }
    await startCameraPreview();
  }

  Future<void> toggleMicrophone() async {
    final enabled = !state.microphoneEnabled;
    emit(state.copyWith(microphoneEnabled: enabled));
    if (_controller != null &&
        _controller!.value.isInitialized &&
        state.cameraEnabled) {
      await _bindCamera(state.lensDirection, enableAudio: enabled);
      emit(
        state.copyWith(
          previewReady: true,
          microphoneEnabled: enabled,
          status: LiveMediaStatus.ready,
        ),
      );
    }
  }

  Future<void> toggleSpeaker() async {
    emit(state.copyWith(speakerEnabled: !state.speakerEnabled));
  }

  Future<void> switchCamera() async {
    if (_cameras.length < 2) return;
    final nextLens = state.lensDirection == CameraLensDirection.front
        ? CameraLensDirection.back
        : CameraLensDirection.front;
    emit(
      state.copyWith(
        lensDirection: nextLens,
        previewReady: false,
        status: LiveMediaStatus.initializing,
      ),
    );
    try {
      await _bindCamera(nextLens);
      emit(
        state.copyWith(
          status: LiveMediaStatus.ready,
          previewReady: true,
          lensDirection: nextLens,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: LiveMediaStatus.error,
          cameraEnabled: false,
          previewReady: false,
          errorMessage: () => 'Could not switch camera',
        ),
      );
    }
  }

  void toggleBeautyFilter() {
    emit(state.copyWith(beautyFilterEnabled: !state.beautyFilterEnabled));
  }

  void toggleBackgroundBlur() {
    emit(state.copyWith(backgroundBlurEnabled: !state.backgroundBlurEnabled));
  }

  Future<void> startScreenShare() async {
    emit(state.copyWith(screenSharing: true));
  }

  Future<void> stopScreenShare() async {
    emit(state.copyWith(screenSharing: false));
  }

  Future<void> stopCameraPreview() async {
    _startInFlight = null;
    await _controller?.dispose();
    _controller = null;
    emit(
      state.copyWith(
        cameraEnabled: false,
        previewReady: false,
        status: LiveMediaStatus.idle,
      ),
    );
  }

  Future<void> recoverStream() async {
    await startCameraPreview();
  }

  @override
  Future<void> close() async {
    _startInFlight = null;
    await _controller?.dispose();
    _controller = null;
    return super.close();
  }
}
