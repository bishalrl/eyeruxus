import 'package:flutter/material.dart';

/// Bottom action row for live rooms — matches the legacy room mockup layout.
class LiveRoomBottomBar extends StatelessWidget {
  const LiveRoomBottomBar({
    super.key,
    required this.onComment,
    required this.onMic,
    required this.onInbox,
    required this.onMore,
    required this.onTakeSeat,
    required this.onGift,
    this.inboxBadgeCount = 0,
    this.micActive = true,
  });

  final VoidCallback onComment;
  final VoidCallback onMic;
  final VoidCallback onInbox;
  final VoidCallback onMore;
  final VoidCallback onTakeSeat;
  final VoidCallback onGift;
  final int inboxBadgeCount;
  final bool micActive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
      child: Row(
        children: [
          Expanded(
            child: _ButtonGroup(
              children: [
                _CircleAction(
                  icon: Icons.chat_bubble_outline,
                  onTap: onComment,
                ),
                _CircleAction(
                  icon: micActive ? Icons.mic : Icons.mic_off,
                  onTap: onMic,
                ),
                _CircleAction(
                  icon: Icons.mail_outline,
                  onTap: onInbox,
                  badgeCount: inboxBadgeCount,
                ),
              ],
            ),
          ),
          const SizedBox(width: 48),
          Expanded(
            child: _ButtonGroup(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _CircleAction(
                  icon: Icons.grid_view_rounded,
                  onTap: onMore,
                ),
                _CircleAction(
                  icon: Icons.chair_outlined,
                  onTap: onTakeSeat,
                ),
                _CircleAction(
                  icon: Icons.card_giftcard,
                  onTap: onGift,
                  iconColor: Colors.pinkAccent,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ButtonGroup extends StatelessWidget {
  const _ButtonGroup({
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        for (var i = 0; i < children.length; i++) ...[
          if (i > 0) const SizedBox(width: 14),
          children[i],
        ],
      ],
    );
  }
}

class _CircleAction extends StatelessWidget {
  const _CircleAction({
    required this.icon,
    required this.onTap,
    this.iconColor = Colors.white,
    this.badgeCount = 0,
  });

  final IconData icon;
  final VoidCallback onTap;
  final Color iconColor;
  final int badgeCount;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.22),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          if (badgeCount > 0)
            Positioned(
              top: -2,
              right: -2,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Color(0xFFE53935),
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                child: Text(
                  '$badgeCount',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class LiveRoomJoinBanner extends StatelessWidget {
  const LiveRoomJoinBanner({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.28),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class LiveRoomDividerLine extends StatelessWidget {
  const LiveRoomDividerLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      color: Colors.white.withValues(alpha: 0.35),
    );
  }
}
