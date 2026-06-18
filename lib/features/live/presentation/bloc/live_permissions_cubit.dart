import 'package:equatable/equatable.dart';
import 'package:eye_rex_us/features/live/presentation/services/live_permissions_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum LivePermissionsGateStatus { checking, ready, denied, error }

class LivePermissionsState extends Equatable {
  const LivePermissionsState({
    this.status = LivePermissionsGateStatus.checking,
    this.forBroadcast = true,
    this.statuses = const {},
    this.errorMessage,
  });

  final LivePermissionsGateStatus status;
  final bool forBroadcast;
  final Map<LivePermissionType, LivePermissionStatus> statuses;
  final String? errorMessage;

  List<LivePermissionType> get requiredTypes => forBroadcast
      ? LivePermissionsServiceImpl.broadcastTypes
      : [LivePermissionType.microphone];

  bool get allRequiredGranted =>
      requiredTypes.every((t) => statuses[t]?.granted ?? false);

  bool get hasPermanentDenial =>
      statuses.values.any((status) => status.permanentlyDenied);

  bool get isLoading =>
      status == LivePermissionsGateStatus.checking;

  LivePermissionsState copyWith({
    LivePermissionsGateStatus? status,
    bool? forBroadcast,
    Map<LivePermissionType, LivePermissionStatus>? statuses,
    String? Function()? errorMessage,
  }) {
    return LivePermissionsState(
      status: status ?? this.status,
      forBroadcast: forBroadcast ?? this.forBroadcast,
      statuses: statuses ?? this.statuses,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, forBroadcast, statuses, errorMessage];
}

class LivePermissionsCubit extends Cubit<LivePermissionsState> {
  LivePermissionsCubit(this._service, {required bool forBroadcast})
      : super(LivePermissionsState(forBroadcast: forBroadcast)) {
    check();
  }

  final LivePermissionsService _service;

  Future<void> check() async {
    emit(
      state.copyWith(
        status: LivePermissionsGateStatus.checking,
        errorMessage: () => null,
      ),
    );
    final map = <LivePermissionType, LivePermissionStatus>{};
    for (final type in state.requiredTypes) {
      map[type] = await _service.check(type);
    }
    emit(
      state.copyWith(
        statuses: map,
        status: map.values.every((s) => s.granted)
            ? LivePermissionsGateStatus.ready
            : LivePermissionsGateStatus.denied,
      ),
    );
  }

  Future<bool> requestAll() async {
    emit(
      state.copyWith(
        status: LivePermissionsGateStatus.checking,
        errorMessage: () => null,
      ),
    );
    final results = state.forBroadcast
        ? await _service.requestBroadcastPermissions()
        : await _service
            .request(LivePermissionType.microphone)
            .then((mic) => {LivePermissionType.microphone: mic});

    final granted = state.requiredTypes.every((t) => results[t]?.granted ?? false);
    emit(
      state.copyWith(
        statuses: results,
        status: granted
            ? LivePermissionsGateStatus.ready
            : LivePermissionsGateStatus.denied,
        errorMessage: () => results.values.any((s) => s.permanentlyDenied)
            ? 'Some permissions are permanently denied. Open Settings to enable them.'
            : null,
      ),
    );
    return granted;
  }

  Future<void> openSettings() => _service.openSettings();
}
