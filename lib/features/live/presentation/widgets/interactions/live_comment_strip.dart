import 'package:eye_rex_us/features/live/domain/entities/live_room_comment.dart';
import 'package:flutter/material.dart';

class LiveCommentStrip extends StatelessWidget {
  const LiveCommentStrip({
    super.key,
    required this.comments,
    this.maxHeight = 140,
  });

  final List<LiveRoomComment> comments;
  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    final visible = comments.length > 6 ? comments.sublist(comments.length - 6) : comments;

    return SizedBox(
      height: maxHeight,
      child: ListView.builder(
        itemCount: visible.length,
        itemBuilder: (context, index) {
          final comment = visible[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(12),
              ),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${comment.authorName}: ',
                      style: const TextStyle(
                        color: Color(0xFFFFD54F),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    TextSpan(
                      text: comment.text,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
