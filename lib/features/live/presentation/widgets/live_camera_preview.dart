import 'package:camera/camera.dart';
import 'package:eye_rex_us/features/live/presentation/bloc/live_media_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Renders the local camera feed driven by [LiveMediaCubit] — no setState.
class LiveCameraPreview extends StatelessWidget {
  const LiveCameraPreview({
    super.key,
    this.borderRadius = BorderRadius.zero,
    this.fit = BoxFit.cover,
  });

  final BorderRadius borderRadius;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LiveMediaCubit, LiveMediaState>(
      buildWhen: (prev, curr) =>
          prev.previewReady != curr.previewReady ||
          prev.cameraEnabled != curr.cameraEnabled ||
          prev.status != curr.status ||
          prev.lensDirection != curr.lensDirection ||
          prev.errorMessage != curr.errorMessage,
      builder: (context, state) {
        if (state.status == LiveMediaStatus.initializing) {
          return _CameraPlaceholder(
            borderRadius: borderRadius,
            icon: Icons.hourglass_empty,
            label: 'Starting camera…',
            loading: true,
          );
        }

        if (state.status == LiveMediaStatus.error) {
          return _CameraPlaceholder(
            borderRadius: borderRadius,
            icon: Icons.videocam_off,
            label: state.errorMessage ?? 'Camera unavailable',
            onTap: () => context.read<LiveMediaCubit>().startCameraPreview(),
          );
        }

        if (!state.cameraEnabled || !state.previewReady) {
          return _CameraPlaceholder(
            borderRadius: borderRadius,
            icon: Icons.videocam_off,
            label: 'Camera off',
            onTap: () => context.read<LiveMediaCubit>().startCameraPreview(),
          );
        }

        final cubit = context.read<LiveMediaCubit>();
        final controller = cubit.previewController;

        if (controller == null || !controller.value.isInitialized) {
          return _CameraPlaceholder(
            borderRadius: borderRadius,
            icon: Icons.hourglass_empty,
            label: 'Starting camera…',
            loading: true,
          );
        }

        return ClipRRect(
          borderRadius: borderRadius,
          child: ListenableBuilder(
            listenable: controller,
            builder: (context, _) {
              if (!controller.value.isInitialized) {
                return _CameraPlaceholder(
                  borderRadius: borderRadius,
                  icon: Icons.hourglass_empty,
                  label: 'Starting camera…',
                  loading: true,
                );
              }

              final previewSize = controller.value.previewSize;
              if (previewSize == null) {
                return CameraPreview(controller);
              }

              return FittedBox(
                fit: fit,
                clipBehavior: Clip.hardEdge,
                child: SizedBox(
                  width: previewSize.height,
                  height: previewSize.width,
                  child: CameraPreview(controller),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _CameraPlaceholder extends StatelessWidget {
  const _CameraPlaceholder({
    required this.borderRadius,
    required this.icon,
    required this.label,
    this.loading = false,
    this.onTap,
  });

  final BorderRadius borderRadius;
  final IconData icon;
  final String label;
  final bool loading;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: borderRadius,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (loading)
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white54,
                    ),
                  ),
                )
              else
                Icon(icon, color: Colors.white54, size: 28),
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white54, fontSize: 10),
                ),
              ),
              if (onTap != null) ...[
                const SizedBox(height: 4),
                const Text(
                  'Tap to retry',
                  style: TextStyle(color: Colors.white38, fontSize: 9),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
