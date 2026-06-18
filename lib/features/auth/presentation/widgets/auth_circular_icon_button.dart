import 'package:eye_rex_us/features/auth/presentation/theme/auth_theme.dart';
import 'package:flutter/material.dart';

/// Circular outlined icon button for alternate login methods.
class AuthCircularIconButton extends StatelessWidget {
  const AuthCircularIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.enabled = true,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final bool enabled;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final button = Material(
      color: Colors.white,
      shape: const CircleBorder(
        side: BorderSide(color: AuthTheme.brandAccent, width: 1.5),
      ),
      child: InkWell(
        onTap: enabled ? onPressed : null,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 56,
          height: 56,
          child: Icon(
            icon,
            size: 26,
            color: enabled ? AuthTheme.brandAccent : AuthTheme.brandMuted,
          ),
        ),
      ),
    );

    if (tooltip == null) return button;
    return Tooltip(message: tooltip!, child: button);
  }
}
