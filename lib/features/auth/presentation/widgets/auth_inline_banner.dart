import 'package:eye_rex_us/features/auth/presentation/theme/auth_theme.dart';
import 'package:eye_rex_us/features/auth/presentation/widgets/auth_feedback.dart';
import 'package:flutter/material.dart';

class AuthInlineBanner extends StatelessWidget {
  const AuthInlineBanner({
    super.key,
    required this.feedback,
    this.onDismiss,
  });

  final AuthFeedbackMessage feedback;
  final VoidCallback? onDismiss;

  @override
  Widget build(BuildContext context) {
    final (icon, bg, border, fg) = _styleFor(feedback.type);

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
      child: Material(
        color: Colors.transparent,
        child: AnimatedSize(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: border),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: fg, size: 22),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    feedback.message,
                    style: AuthTheme.bodyMd(context).copyWith(
                      color: fg,
                      fontWeight: FontWeight.w500,
                      height: 1.45,
                    ),
                  ),
                ),
                if (onDismiss != null)
                  IconButton(
                    onPressed: onDismiss,
                    icon: Icon(Icons.close, size: 18, color: fg.withValues(alpha: 0.7)),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                    visualDensity: VisualDensity.compact,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  (IconData, Color, Color, Color) _styleFor(AuthFeedbackType type) {
    switch (type) {
      case AuthFeedbackType.success:
        return (
          Icons.check_circle_rounded,
          const Color(0xFFE8F5E9),
          const Color(0xFFA5D6A7),
          const Color(0xFF2E7D32),
        );
      case AuthFeedbackType.error:
        return (
          Icons.error_outline_rounded,
          AuthTheme.errorContainer,
          const Color(0xFFFFB4AB),
          AuthTheme.error,
        );
      case AuthFeedbackType.info:
        return (
          Icons.info_outline_rounded,
          AuthTheme.surfaceContainerLow,
          AuthTheme.primary.withValues(alpha: 0.25),
          AuthTheme.primary,
        );
    }
  }
}
