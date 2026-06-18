import 'package:eye_rex_us/features/live/presentation/bloc/live_room_interaction_cubit.dart';
import 'package:eye_rex_us/features/live/presentation/bloc/live_room_interaction_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Mic / camera / flip controls when the viewer is on a guest seat.
class GuestSeatFloatingControls extends StatelessWidget {
  const GuestSeatFloatingControls({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LiveRoomInteractionCubit, LiveRoomInteractionState>(
      buildWhen: (prev, curr) =>
          prev.session?.seats != curr.session?.seats ||
          prev.micEnabled != curr.micEnabled ||
          prev.cameraEnabled != curr.cameraEnabled ||
          prev.speakerEnabled != curr.speakerEnabled,
      builder: (context, state) {
        final session = state.session;
        if (session == null) return const SizedBox.shrink();
        final onSeat = session.seats.any((s) => s.participant?.id == 'me');
        if (!onSeat) return const SizedBox.shrink();

        final cubit = context.read<LiveRoomInteractionCubit>();

        return Positioned(
          right: 12,
          top: 120,
          child: Column(
            children: [
              _GuestControlBtn(
                icon: Icons.cameraswitch_outlined,
                label: 'Flip',
                onTap: cubit.switchCamera,
              ),
              _GuestControlBtn(
                icon: state.micEnabled ? Icons.mic : Icons.mic_off,
                label: 'Mic',
                onTap: cubit.toggleMic,
              ),
              _GuestControlBtn(
                icon: state.cameraEnabled ? Icons.videocam : Icons.videocam_off,
                label: 'Cam',
                onTap: cubit.toggleCamera,
              ),
              _GuestControlBtn(
                icon: state.speakerEnabled ? Icons.volume_up : Icons.volume_off,
                label: 'Audio',
                onTap: cubit.toggleSpeaker,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _GuestControlBtn extends StatelessWidget {
  const _GuestControlBtn({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Column(
              children: [
                Icon(icon, color: Colors.white, size: 22),
                const SizedBox(height: 2),
                Text(
                  label,
                  style: const TextStyle(color: Colors.white70, fontSize: 9),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
