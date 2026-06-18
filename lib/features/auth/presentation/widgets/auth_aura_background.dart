import 'package:flutter/material.dart';

import '../theme/auth_theme.dart';

class AuthAuraBackground extends StatelessWidget {
  const AuthAuraBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -MediaQuery.sizeOf(context).height * 0.1,
          left: -MediaQuery.sizeOf(context).width * 0.1,
          child: _AuraBlob(color: AuthTheme.primary.withValues(alpha: 0.15)),
        ),
        Positioned(
          bottom: -MediaQuery.sizeOf(context).height * 0.1,
          right: -MediaQuery.sizeOf(context).width * 0.1,
          child: _AuraBlob(color: AuthTheme.secondaryContainer.withValues(alpha: 0.15)),
        ),
        child,
      ],
    );
  }
}

class _AuraBlob extends StatelessWidget {
  const _AuraBlob({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context).width * 0.4;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: 100,
            spreadRadius: 20,
          ),
        ],
      ),
    );
  }
}
