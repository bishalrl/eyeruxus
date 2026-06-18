import 'package:eye_rex_us/features/live/presentation/bloc/live_room_interaction_cubit.dart';
import 'package:eye_rex_us/features/live/presentation/theme/live_room_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewerLiveBottomBar extends StatelessWidget {
  const ViewerLiveBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LiveRoomInteractionCubit>();

    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: LiveRoomTheme.glass(radius: 28),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: cubit.openCommentSheet,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  'Say something…',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 13),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          _ViewerAction(icon: Icons.favorite_border, onTap: () => cubit.sendReaction('❤️')),
          _ViewerAction(icon: Icons.local_fire_department_outlined, onTap: () => cubit.sendReaction('🔥')),
          _ViewerAction(icon: Icons.card_giftcard, color: Colors.pinkAccent, onTap: cubit.openGiftPanel),
          _ViewerAction(icon: Icons.event_seat_outlined, onTap: cubit.openSeatSheet),
          _ViewerAction(icon: Icons.more_horiz, onTap: cubit.openMoreMenu),
        ],
      ),
    );
  }
}

class _ViewerAction extends StatelessWidget {
  const _ViewerAction({
    required this.icon,
    required this.onTap,
    this.color = Colors.white,
  });

  final IconData icon;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: IconButton(
        onPressed: onTap,
        icon: Icon(icon, color: color, size: 24),
        style: IconButton.styleFrom(
          backgroundColor: Colors.white.withValues(alpha: 0.1),
        ),
      ),
    );
  }
}
