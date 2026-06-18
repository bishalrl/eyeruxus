import 'package:flutter/material.dart';

class FloatingButtonK extends StatelessWidget {
  const FloatingButtonK({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _actionButton(Icons.card_giftcard, Colors.pinkAccent),
          const SizedBox(width: 12),
          _actionButton(Icons.mic, Colors.white),
          const SizedBox(width: 12),
          _actionButton(Icons.chat_bubble_outline, Colors.white),
          const SizedBox(width: 12),
          _actionButton(Icons.more_horiz, Colors.white),
        ],
      ),
    );
  }

  Widget _actionButton(IconData icon, Color color) {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white24,
      ),
      child: Icon(icon, color: color, size: 22),
    );
  }
}
