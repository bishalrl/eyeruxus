import 'package:eye_rex_us/features/live/presentation/bloc/live_room_interaction_cubit.dart';
import 'package:eye_rex_us/features/live/presentation/theme/live_room_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HostStudioBottomBar extends StatelessWidget {
  const HostStudioBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LiveRoomInteractionCubit>();
    final state = context.watch<LiveRoomInteractionCubit>().state;
    final locked = state.session?.settings.seatsLocked ?? false;

    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: LiveRoomTheme.glass(radius: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StudioAction(
            icon: Icons.volume_off_outlined,
            label: 'Mute chat',
            onTap: cubit.toggleRoomMute,
            active: !(state.session?.settings.chatEnabled ?? true),
          ),
          _StudioAction(
            icon: locked ? Icons.lock : Icons.lock_open_outlined,
            label: locked ? 'Unlock' : 'Lock',
            onTap: cubit.toggleRoomLock,
            active: locked,
          ),
          _StudioAction(
            icon: Icons.event_seat_outlined,
            label: 'Seats',
            onTap: cubit.openHostControls,
            badge: state.seatRequests.length,
          ),
          _StudioAction(
            icon: Icons.person_add_alt_1,
            label: 'Invite',
            onTap: cubit.inviteViewers,
          ),
          _StudioAction(
            icon: Icons.card_giftcard,
            label: 'Gifts',
            onTap: cubit.openGiftDashboard,
          ),
          _StudioAction(
            icon: Icons.insights_outlined,
            label: 'Analytics',
            onTap: cubit.openAnalytics,
          ),
          _StudioAction(
            icon: Icons.shield_outlined,
            label: 'Mod',
            onTap: cubit.openModerationPanel,
          ),
        ],
      ),
    );
  }
}

class _StudioAction extends StatelessWidget {
  const _StudioAction({
    required this.icon,
    required this.label,
    required this.onTap,
    this.badge = 0,
    this.active = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final int badge;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: active
                      ? LiveRoomTheme.accent.withValues(alpha: 0.5)
                      : Colors.white.withValues(alpha: 0.12),
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
              if (badge > 0)
                Positioned(
                  top: -4,
                  right: -4,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.redAccent,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$badge',
                      style: const TextStyle(color: Colors.white, fontSize: 9),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 9)),
        ],
      ),
    );
  }
}

class HostFloatingControls extends StatelessWidget {
  const HostFloatingControls({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LiveRoomInteractionCubit>();
    final state = context.watch<LiveRoomInteractionCubit>().state;

    return Positioned(
      right: 12,
      top: 120,
      child: Column(
        children: [
          _FloatBtn(
            icon: Icons.stop_circle,
            label: 'End',
            color: LiveRoomTheme.accent,
            onTap: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  backgroundColor: const Color(0xFF2A1010),
                  title: const Text('End live?', style: TextStyle(color: Colors.white)),
                  content: const Text(
                    'This will end the session for all viewers.',
                    style: TextStyle(color: Colors.white70),
                  ),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                    FilledButton(
                      onPressed: () => Navigator.pop(ctx, true),
                      style: FilledButton.styleFrom(backgroundColor: LiveRoomTheme.accent),
                      child: const Text('End live'),
                    ),
                  ],
                ),
              );
              if (confirm == true && context.mounted) {
                await cubit.endRoom();
              }
            },
          ),
          _FloatBtn(
            icon: Icons.cameraswitch_outlined,
            label: 'Flip',
            onTap: cubit.switchCamera,
          ),
          _FloatBtn(
            icon: state.micEnabled ? Icons.mic : Icons.mic_off,
            label: 'Mic',
            onTap: cubit.toggleMic,
          ),
          _FloatBtn(
            icon: state.cameraEnabled ? Icons.videocam : Icons.videocam_off,
            label: 'Cam',
            onTap: cubit.toggleCamera,
          ),
          _FloatBtn(
            icon: Icons.face_retouching_natural,
            label: 'Beauty',
            active: state.beautyFilterEnabled,
            onTap: cubit.toggleBeautyFilter,
          ),
          _FloatBtn(
            icon: Icons.blur_on,
            label: 'Blur',
            active: state.backgroundBlurEnabled,
            onTap: cubit.toggleBackgroundBlur,
          ),
          _FloatBtn(
            icon: Icons.screen_share_outlined,
            label: 'Share',
            onTap: cubit.startScreenShare,
          ),
        ],
      ),
    );
  }
}

class _FloatBtn extends StatelessWidget {
  const _FloatBtn({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
    this.active = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color ?? (active ? LiveRoomTheme.accent : Colors.black54),
                border: Border.all(color: Colors.white24),
              ),
              child: Icon(icon, color: Colors.white, size: 22),
            ),
            const SizedBox(height: 2),
            Text(label, style: const TextStyle(color: Colors.white70, fontSize: 9)),
          ],
        ),
      ),
    );
  }
}
