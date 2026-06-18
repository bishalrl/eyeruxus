import 'package:eye_rex_us/features/live/presentation/bloc/live_room_interaction_state.dart';
import 'package:eye_rex_us/features/live/presentation/theme/live_room_theme.dart';
import 'package:flutter/material.dart';

class HostStudioHeader extends StatelessWidget {
  const HostStudioHeader({
    super.key,
    required this.state,
    required this.roomId,
  });

  final LiveRoomInteractionState state;
  final String roomId;

  @override
  Widget build(BuildContext context) {
    final session = state.session;
    final host = session?.host;
    final analytics = state.hostAnalytics;

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 6),
      child: Column(
        children: [
          Row(
            children: [
              if (host != null)
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(host.avatarUrl),
                ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      host?.name ?? 'Host',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      session?.title ?? 'Live Studio',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.65), fontSize: 11),
                    ),
                  ],
                ),
              ),
              _StudioChip(label: 'LIVE', color: LiveRoomTheme.accent),
              const SizedBox(width: 6),
              _StudioChip(
                label: LiveRoomTheme.formatDuration(analytics.liveDurationSeconds),
                icon: Icons.timer_outlined,
              ),
            ],
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _StatPill(icon: Icons.tag, label: 'ID', value: roomId.toUpperCase()),
                _StatPill(
                  icon: Icons.remove_red_eye_outlined,
                  label: 'Viewers',
                  value: LiveRoomTheme.formatCount(state.viewerCount),
                ),
                _StatPill(
                  icon: Icons.people_outline,
                  label: 'Followers',
                  value: LiveRoomTheme.formatCount(analytics.followersCount),
                ),
                _StatPill(
                  icon: Icons.card_giftcard,
                  label: 'Gifts',
                  value: '${analytics.giftEarnings}',
                ),
                _StatPill(
                  icon: Icons.monetization_on_outlined,
                  label: 'Revenue',
                  value: '${analytics.revenueTotal}',
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.share_outlined, color: Colors.white, size: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StudioChip extends StatelessWidget {
  const _StudioChip({required this.label, this.color, this.icon});

  final String label;
  final Color? color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: LiveRoomTheme.glass(
        color: color ?? Colors.white,
        opacity: color != null ? 0.9 : 0.1,
        radius: 8,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: Colors.white70),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              color: color != null ? Colors.white : Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatPill extends StatelessWidget {
  const _StatPill({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: LiveRoomTheme.glass(radius: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: LiveRoomTheme.gold),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(color: Colors.white54, fontSize: 10)),
          const SizedBox(width: 4),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
