import 'package:eye_rex_us/features/live/presentation/bloc/live_room_interaction_cubit.dart';
import 'package:eye_rex_us/features/live/presentation/bloc/live_room_interaction_state.dart';
import 'package:eye_rex_us/features/live/presentation/host/widgets/host_studio_header.dart';
import 'package:eye_rex_us/features/live/presentation/theme/live_room_theme.dart';
import 'package:eye_rex_us/features/live/presentation/widgets/live_seat_stage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Host broadcasting studio — separate from viewer experience.
class HostLiveStudioPage extends StatelessWidget {
  const HostLiveStudioPage({super.key, required this.roomId});

  final String roomId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LiveRoomInteractionCubit, LiveRoomInteractionState>(
      builder: (context, state) {
        if (state.status == LiveRoomLoadStatus.loading) {
          return const _HostLoading();
        }
        if (state.status == LiveRoomLoadStatus.error) {
          return _HostError(
            message: state.errorMessage ?? 'Studio connection failed',
            onRetry: () => context.read<LiveRoomInteractionCubit>().rejoin(),
          );
        }
        if (state.status == LiveRoomLoadStatus.ended) {
          return _HostEnded(onClose: () => Navigator.maybePop(context));
        }

        final session = state.session;
        return Container(
          decoration: const BoxDecoration(gradient: LiveRoomTheme.hostGradient),
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                HostStudioHeader(state: state, roomId: roomId),
                Expanded(
                  child: session == null
                      ? const Center(
                          child: CircularProgressIndicator(color: LiveRoomTheme.accent),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: LiveSeatStage(
                            session: session,
                            allowSeatRequests: false,
                            emphasizeHostSeat: true,
                            enableGuestManage: true,
                          ),
                        ),
                ),
                const SizedBox(height: 148),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _HostLoading extends StatelessWidget {
  const _HostLoading();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: LiveRoomTheme.hostGradient),
      child: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: LiveRoomTheme.accent),
            SizedBox(height: 16),
            Text('Preparing your studio…', style: TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}

class _HostError extends StatelessWidget {
  const _HostError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: LiveRoomTheme.hostGradient),
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.settings_voice, color: Colors.white54, size: 48),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onRetry,
              style: FilledButton.styleFrom(backgroundColor: LiveRoomTheme.accent),
              child: const Text('Reconnect studio'),
            ),
          ],
        ),
      ),
    );
  }
}

class _HostEnded extends StatelessWidget {
  const _HostEnded({required this.onClose});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: LiveRoomTheme.hostGradient),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.greenAccent, size: 56),
            const SizedBox(height: 12),
            const Text('Live session ended', style: TextStyle(color: Colors.white, fontSize: 18)),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onClose,
              style: FilledButton.styleFrom(backgroundColor: LiveRoomTheme.accent),
              child: const Text('Back to dashboard'),
            ),
          ],
        ),
      ),
    );
  }
}
