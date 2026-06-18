import 'package:flutter/material.dart';

import '../theme/auth_theme.dart';

class AuthGradientButton extends StatelessWidget {
  const AuthGradientButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.uppercase = false,
    this.borderRadius = 12,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final bool uppercase;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null && !isLoading;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: enabled ? AuthTheme.gradient : null,
        color: enabled ? null : AuthTheme.outlineVariant,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: enabled
            ? [
                BoxShadow(
                  color: AuthTheme.primary.withValues(alpha: 0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: enabled ? onPressed : null,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLoading)
                  const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AuthTheme.onPrimary,
                    ),
                  )
                else ...[
                  Text(
                    uppercase ? label.toUpperCase() : label,
                    style: AuthTheme.headlineMd(context).copyWith(
                      fontSize: uppercase ? 14 : 24,
                      color: AuthTheme.onPrimary,
                      letterSpacing: uppercase ? 2 : 0,
                    ),
                  ),
                  if (icon != null) ...[
                    const SizedBox(width: 8),
                    Icon(icon, color: AuthTheme.onPrimary, size: 20),
                  ],
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
