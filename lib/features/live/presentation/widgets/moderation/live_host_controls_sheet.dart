import 'package:eye_rex_us/features/live/domain/entities/live_session_entities.dart';
import 'package:eye_rex_us/features/live/presentation/bloc/live_room_interaction_cubit.dart';
import 'package:eye_rex_us/features/live/presentation/bloc/live_room_interaction_state.dart';
import 'package:eye_rex_us/features/live/presentation/widgets/moderation/live_participant_owner_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LiveHostControlsSheet extends StatelessWidget {
  const LiveHostControlsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LiveRoomInteractionCubit, LiveRoomInteractionState>(
      builder: (context, state) {
        final cubit = context.read<LiveRoomInteractionCubit>();
        final session = state.session;
        final settings = session?.settings ?? const LiveRoomSettings();
        final isOwner = state.isHost;
        final canManage = state.canModerate;

        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
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
                Text(
                  isOwner ? 'Room owner controls' : 'Host controls',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (isOwner)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      'Manage guests, seats, and room settings',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.55), fontSize: 12),
                    ),
                  ),
                const SizedBox(height: 16),
                if (state.seatRequests.isNotEmpty) ...[
                  const Text(
                    'Join requests',
                    style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  for (final request in state.seatRequests)
                    _SeatRequestTile(
                      request: request,
                      enabled: isOwner,
                      onApprove: () => cubit.approveSeatRequest(request.id),
                      onReject: () => cubit.rejectSeatRequest(request.id),
                    ),
                  const SizedBox(height: 12),
                ],
                if (session != null) ...[
                  const Text(
                    'On stage',
                    style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  for (var i = 0; i < session.seats.length; i++)
                    if (session.seats[i].participant != null &&
                        !LiveRoomInteractionCubit.isHostParticipant(
                          session.seats[i].participant!,
                        ))
                      _GuestControlTile(
                        participant: session.seats[i].participant!,
                        seatIndex: i,
                        enabled: canManage,
                        onOpen: () => showGuestManageMenu(
                          context,
                          participant: session.seats[i].participant!,
                          seatIndex: i,
                        ),
                        onMute: () => cubit.muteParticipant(
                          session.seats[i].participant!.id,
                          muted: !session.seats[i].participant!.isMuted,
                        ),
                        onCamera: () => cubit.setParticipantCamera(
                          session.seats[i].participant!.id,
                          cameraOff: !session.seats[i].participant!.isCameraOff,
                        ),
                        onKick: () => cubit.kickParticipant(session.seats[i].participant!.id),
                      ),
                  const SizedBox(height: 12),
                ],
                const Text(
                  'Room settings',
                  style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                _ToggleTile(
                  label: 'Chat',
                  value: settings.chatEnabled,
                  enabled: isOwner,
                  onChanged: (v) => cubit.updateSettings(
                    settings.copyWith(chatEnabled: v),
                  ),
                ),
                _ToggleTile(
                  label: 'Gifts',
                  value: settings.giftsEnabled,
                  enabled: isOwner,
                  onChanged: (v) => cubit.updateSettings(
                    settings.copyWith(giftsEnabled: v),
                  ),
                ),
                _ToggleTile(
                  label: 'Allow join requests',
                  value: settings.seatRequestsEnabled,
                  enabled: isOwner,
                  onChanged: (v) => cubit.updateSettings(
                    settings.copyWith(seatRequestsEnabled: v),
                  ),
                ),
                _ToggleTile(
                  label: 'Lock seats',
                  value: settings.seatsLocked,
                  enabled: isOwner,
                  onChanged: (v) => cubit.updateSettings(
                    settings.copyWith(seatsLocked: v),
                  ),
                ),
                _ToggleTile(
                  label: 'Reactions',
                  value: settings.reactionsEnabled,
                  enabled: isOwner,
                  onChanged: (v) => cubit.updateSettings(
                    settings.copyWith(reactionsEnabled: v),
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: isOwner
                      ? () async {
                          Navigator.pop(context);
                          await cubit.endRoom();
                        }
                      : null,
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFFAF1D18),
                  ),
                  icon: const Icon(Icons.stop_circle_outlined),
                  label: const Text('End live'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _GuestControlTile extends StatelessWidget {
  const _GuestControlTile({
    required this.participant,
    required this.seatIndex,
    required this.enabled,
    required this.onOpen,
    required this.onMute,
    required this.onCamera,
    required this.onKick,
  });

  final LiveParticipant participant;
  final int seatIndex;
  final bool enabled;
  final VoidCallback onOpen;
  final VoidCallback onMute;
  final VoidCallback onCamera;
  final VoidCallback onKick;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white10,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: enabled ? onOpen : null,
        leading: CircleAvatar(backgroundImage: NetworkImage(participant.avatarUrl)),
        title: Text(participant.name, style: const TextStyle(color: Colors.white)),
        subtitle: Text(
          'Seat ${seatIndex + 1} · ${participant.role.name}',
          style: const TextStyle(color: Colors.white54, fontSize: 11),
        ),
        trailing: enabled
            ? Wrap(
                spacing: 0,
                children: [
                  IconButton(
                    tooltip: participant.isMuted ? 'Unmute' : 'Mute',
                    icon: Icon(
                      participant.isMuted ? Icons.mic_off : Icons.mic,
                      color: participant.isMuted ? Colors.redAccent : Colors.white70,
                      size: 20,
                    ),
                    onPressed: onMute,
                  ),
                  IconButton(
                    tooltip: participant.isCameraOff ? 'Camera on' : 'Camera off',
                    icon: Icon(
                      participant.isCameraOff ? Icons.videocam_off : Icons.videocam,
                      color: participant.isCameraOff ? Colors.redAccent : Colors.white70,
                      size: 20,
                    ),
                    onPressed: onCamera,
                  ),
                  IconButton(
                    tooltip: 'Kick',
                    icon: const Icon(Icons.person_remove, color: Colors.redAccent, size: 20),
                    onPressed: onKick,
                  ),
                ],
              )
            : null,
      ),
    );
  }
}

class _ToggleTile extends StatelessWidget {
  const _ToggleTile({
    required this.label,
    required this.value,
    required this.onChanged,
    this.enabled = true,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(label, style: const TextStyle(color: Colors.white)),
      value: value,
      activeTrackColor: const Color(0xFFAF1D18),
      onChanged: enabled ? onChanged : null,
    );
  }
}

class _SeatRequestTile extends StatelessWidget {
  const _SeatRequestTile({
    required this.request,
    required this.onApprove,
    required this.onReject,
    this.enabled = true,
  });

  final LiveSeatRequest request;
  final VoidCallback onApprove;
  final VoidCallback onReject;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white10,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(request.avatarUrl)),
        title: Text(request.userName, style: const TextStyle(color: Colors.white)),
        subtitle: Text(
          'Wants seat ${request.seatIndex + 1}',
          style: const TextStyle(color: Colors.white54),
        ),
        trailing: enabled
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.check_circle, color: Colors.greenAccent),
                    onPressed: onApprove,
                  ),
                  IconButton(
                    icon: const Icon(Icons.cancel, color: Colors.redAccent),
                    onPressed: onReject,
                  ),
                ],
              )
            : null,
      ),
    );
  }
}
