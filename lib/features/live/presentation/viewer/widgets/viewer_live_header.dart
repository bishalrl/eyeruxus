import 'package:eye_rex_us/features/live/presentation/bloc/live_room_interaction_cubit.dart';
import 'package:eye_rex_us/features/live/presentation/bloc/live_room_interaction_state.dart';
import 'package:eye_rex_us/features/live/presentation/theme/live_room_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewerLiveHeader extends StatelessWidget {
  const ViewerLiveHeader({super.key, required this.state});

  final LiveRoomInteractionState state;

  @override
  Widget build(BuildContext context) {
    final host = state.session?.host;
    final cubit = context.read<LiveRoomInteractionCubit>();

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
      child: Row(
        children: [
          if (host != null) ...[
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(host.avatarUrl),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    host.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: LiveRoomTheme.accent,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'LIVE',
                          style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w800),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.remove_red_eye_outlined, size: 12, color: Colors.white.withValues(alpha: 0.6)),
                      const SizedBox(width: 4),
                      Text(
                        LiveRoomTheme.formatCount(state.viewerCount),
                        style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 11),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
          _FollowChip(
            following: state.isFollowingHost,
            onTap: cubit.toggleFollowHost,
          ),
          const SizedBox(width: 6),
          IconButton(
            onPressed: cubit.share,
            icon: const Icon(Icons.ios_share, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }
}

class _FollowChip extends StatelessWidget {
  const _FollowChip({required this.following, required this.onTap});

  final bool following;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: following ? Colors.white24 : LiveRoomTheme.accent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          following ? 'Following' : 'Follow',
          style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
