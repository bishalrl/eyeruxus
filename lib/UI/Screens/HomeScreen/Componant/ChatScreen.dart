import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final double maxHeight;
  final bool isTransparent;

  const ChatScreen({
    super.key,
    required this.maxHeight,
    this.isTransparent = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: maxHeight,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: isTransparent
            ? Colors.transparent
            : Colors.black.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: const [
                _ChatBubble(
                  name: 'System',
                  message: 'Welcome to the live room!',
                  color: Colors.white70,
                ),
                _ChatBubble(
                  name: 'Guest',
                  message: 'Hello everyone',
                  color: Colors.white,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                    decoration: InputDecoration(
                      hintText: 'Say something...',
                      hintStyle: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 13,
                      ),
                      filled: true,
                      fillColor: Colors.white.withValues(alpha: 0.12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.send, color: Colors.white, size: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final String name;
  final String message;
  final Color color;

  const _ChatBubble({
    required this.name,
    required this.message,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$name: ',
              style: TextStyle(
                color: color.withValues(alpha: 0.8),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(
              text: message,
              style: TextStyle(color: color, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
