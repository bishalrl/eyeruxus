import 'package:eye_rex_us/features/live/presentation/bloc/live_room_interaction_cubit.dart';
import 'package:eye_rex_us/features/live/presentation/bloc/live_room_interaction_state.dart';
import 'package:eye_rex_us/features/live/presentation/theme/live_room_theme.dart';
import 'package:eye_rex_us/features/live/presentation/viewer/widgets/viewer_live_header.dart';
import 'package:eye_rex_us/features/live/presentation/widgets/live_seat_stage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Immersive viewer experience — watch, chat, gift, react.
class ViewerLiveRoomPage extends StatelessWidget {
  const ViewerLiveRoomPage({super.key, required this.roomId});

  final String roomId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LiveRoomInteractionCubit, LiveRoomInteractionState>(
      builder: (context, state) {
        if (state.status == LiveRoomLoadStatus.loading) {
          return const _ViewerLoading();
        }
        if (state.status == LiveRoomLoadStatus.error) {
          return _ViewerError(
            message: state.errorMessage ?? 'Could not join live',
            onRetry: () => context.read<LiveRoomInteractionCubit>().rejoin(),
          );
        }
        if (state.status == LiveRoomLoadStatus.ended) {
          return _ViewerEnded(onClose: () => Navigator.maybePop(context));
        }

        final session = state.session;
        return Container(
          decoration: const BoxDecoration(gradient: LiveRoomTheme.viewerGradient),
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                ViewerLiveHeader(state: state),
                Expanded(
                  child: session == null
                      ? const Center(
                          child: CircularProgressIndicator(color: LiveRoomTheme.accent),
                        )
                      : LiveSeatStage(
                          session: session,
                          allowSeatRequests: true,
                          enableGuestManage: true,
                        ),
                ),
                const SizedBox(height: 120),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ViewerLoading extends StatelessWidget {
  const _ViewerLoading();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: LiveRoomTheme.viewerGradient),
      child: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: LiveRoomTheme.accent),
            SizedBox(height: 16),
            Text('Joining live…', style: TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}

class _ViewerError extends StatelessWidget {
  const _ViewerError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: LiveRoomTheme.viewerGradient),
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.live_tv_outlined, color: Colors.white54, size: 48),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onRetry,
              style: FilledButton.styleFrom(backgroundColor: LiveRoomTheme.accent),
              child: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ViewerEnded extends StatelessWidget {
  const _ViewerEnded({required this.onClose});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: LiveRoomTheme.viewerGradient),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.nightlight_round, color: Colors.white54, size: 56),
            const SizedBox(height: 12),
            const Text('Live has ended', style: TextStyle(color: Colors.white, fontSize: 18)),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onClose,
              style: FilledButton.styleFrom(backgroundColor: LiveRoomTheme.accent),
              child: const Text('Leave'),
            ),
          ],
        ),
      ),
    );
  }
}
