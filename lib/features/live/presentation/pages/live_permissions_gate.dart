import 'package:eye_rex_us/app/di/injection.dart';
import 'package:eye_rex_us/features/live/presentation/bloc/live_permissions_cubit.dart';
import 'package:eye_rex_us/features/live/presentation/services/live_permissions_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef LivePermissionsGrantedCallback = void Function();

class LivePermissionsGate extends StatelessWidget {
  const LivePermissionsGate({
    super.key,
    required this.onGranted,
    this.forBroadcast = true,
  });

  final LivePermissionsGrantedCallback onGranted;
  final bool forBroadcast;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LivePermissionsCubit(
        sl<LivePermissionsService>(),
        forBroadcast: forBroadcast,
      ),
      child: _LivePermissionsGateView(onGranted: onGranted),
    );
  }
}

class _LivePermissionsGateView extends StatelessWidget {
  const _LivePermissionsGateView({required this.onGranted});

  final LivePermissionsGrantedCallback onGranted;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LivePermissionsCubit, LivePermissionsState>(
      listenWhen: (prev, curr) =>
          prev.status != curr.status && curr.status == LivePermissionsGateStatus.ready,
      listener: (context, state) => onGranted(),
      builder: (context, state) {
        final cubit = context.read<LivePermissionsCubit>();

        return Scaffold(
          backgroundColor: const Color(0xFF1A1010),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(),
                  const Icon(Icons.videocam_outlined, size: 72, color: Color(0xFFAF1D18)),
                  const SizedBox(height: 16),
                  const Text(
                    'Permissions needed',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.forBroadcast
                        ? 'Camera, microphone, and photo library access are required to go live, set a cover image, and join video rooms.'
                        : 'Microphone access is required for voice rooms.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
                  ),
                  const SizedBox(height: 24),
                  for (final type in state.requiredTypes)
                    if (state.statuses[type] != null)
                      _PermissionRow(type: type, status: state.statuses[type]!),
                  if (state.errorMessage != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      state.errorMessage!,
                      style: const TextStyle(color: Colors.orangeAccent),
                    ),
                  ],
                  const Spacer(),
                  if (state.isLoading)
                    const Center(
                      child: CircularProgressIndicator(color: Color(0xFFAF1D18)),
                    )
                  else ...[
                    FilledButton(
                      onPressed: cubit.requestAll,
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFFAF1D18),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Allow access'),
                    ),
                    const SizedBox(height: 8),
                    if (state.hasPermanentDenial)
                      OutlinedButton(
                        onPressed: cubit.openSettings,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white24),
                        ),
                        child: const Text('Open Settings'),
                      ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PermissionRow extends StatelessWidget {
  const _PermissionRow({required this.type, required this.status});

  final LivePermissionType type;
  final LivePermissionStatus status;

  @override
  Widget build(BuildContext context) {
    final label = switch (type) {
      LivePermissionType.camera => 'Camera',
      LivePermissionType.microphone => 'Microphone',
      LivePermissionType.photos => 'Photo library',
      LivePermissionType.notifications => 'Notifications',
      LivePermissionType.bluetooth => 'Bluetooth audio',
    };
    final icon = status.granted
        ? Icons.check_circle
        : status.permanentlyDenied
            ? Icons.block
            : Icons.error_outline;
    final color = status.granted
        ? Colors.greenAccent
        : status.permanentlyDenied
            ? Colors.redAccent
            : Colors.orangeAccent;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(label, style: const TextStyle(color: Colors.white)),
          ),
          Text(
            status.granted ? 'Granted' : 'Required',
            style: TextStyle(color: color, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
