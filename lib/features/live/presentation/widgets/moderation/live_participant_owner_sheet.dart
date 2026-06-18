import 'package:eye_rex_us/features/live/domain/entities/live_session_entities.dart';
import 'package:eye_rex_us/features/live/presentation/bloc/live_room_interaction_cubit.dart';
import 'package:eye_rex_us/features/live/presentation/bloc/live_room_interaction_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Guest management menu — host & admins (not on host).
class LiveGuestManageMenu extends StatelessWidget {
  const LiveGuestManageMenu({
    super.key,
    required this.participant,
    required this.seatIndex,
  });

  final LiveParticipant participant;
  final int seatIndex;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LiveRoomInteractionCubit, LiveRoomInteractionState>(
      builder: (context, state) {
        final cubit = context.read<LiveRoomInteractionCubit>();
        final session = state.session;
        final p = session?.participants
                .firstWhere((x) => x.id == participant.id, orElse: () => participant) ??
            participant;
        final isPinned = session?.activeSpeakerId == p.id;
        final isOwner = state.isHost;

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundImage: NetworkImage(p.avatarUrl),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            p.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Seat ${seatIndex + 1}',
                            style: const TextStyle(color: Colors.white54, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _ManageAction(
                  icon: Icons.push_pin_outlined,
                  label: isPinned ? 'Unpin' : 'Pin',
                  onTap: () async {
                    await cubit.pinParticipant(p.id);
                    if (context.mounted) Navigator.pop(context);
                  },
                ),
                _ManageAction(
                  icon: p.isMuted ? Icons.mic : Icons.mic_off,
                  label: p.isMuted ? 'Unmute' : 'Mute',
                  onTap: () async {
                    await cubit.muteParticipant(p.id, muted: !p.isMuted);
                    if (context.mounted) Navigator.pop(context);
                  },
                ),
                _ManageAction(
                  icon: p.isCameraOff ? Icons.videocam : Icons.videocam_off,
                  label: p.isCameraOff ? 'Turn video on' : 'Video off',
                  onTap: () async {
                    await cubit.setParticipantCamera(p.id, cameraOff: !p.isCameraOff);
                    if (context.mounted) Navigator.pop(context);
                  },
                ),
                _ManageAction(
                  icon: Icons.person_remove_outlined,
                  label: 'Kick',
                  color: Colors.redAccent,
                  onTap: () async {
                    await cubit.kickParticipant(p.id);
                    if (context.mounted) Navigator.pop(context);
                  },
                ),
                if (isOwner && p.role != LiveParticipantRole.moderator)
                  _ManageAction(
                    icon: Icons.admin_panel_settings_outlined,
                    label: 'Make admin',
                    onTap: () async {
                      await cubit.assignModerator(p.id);
                      if (context.mounted) Navigator.pop(context);
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ManageAction extends StatelessWidget {
  const _ManageAction({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: Icon(icon, color: color ?? Colors.white70, size: 22),
      title: Text(label, style: TextStyle(color: color ?? Colors.white, fontSize: 15)),
      onTap: onTap,
    );
  }
}

void showGuestManageMenu(
  BuildContext context, {
  required LiveParticipant participant,
  required int seatIndex,
}) {
  showModalBottomSheet<void>(
    context: context,
    backgroundColor: const Color(0xFF1A1010),
    builder: (_) => BlocProvider.value(
      value: context.read<LiveRoomInteractionCubit>(),
      child: LiveGuestManageMenu(
        participant: participant,
        seatIndex: seatIndex,
      ),
    ),
  );
}

/// @deprecated Use [showGuestManageMenu].
void showLiveParticipantOwnerSheet(
  BuildContext context, {
  required LiveParticipant participant,
  required int seatIndex,
}) =>
    showGuestManageMenu(
      context,
      participant: participant,
      seatIndex: seatIndex,
    );
