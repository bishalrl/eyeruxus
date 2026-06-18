import 'package:eye_rex_us/core/constants/app_assets.dart';
import 'package:eye_rex_us/shared/widgets/app_asset_image.dart';
import 'package:flutter/material.dart';

import '../theme/auth_theme.dart';

class AuthSocialIconButton extends StatelessWidget {
  const AuthSocialIconButton({
    super.key,
    required this.child,
    required this.onTap,
    this.tooltip,
  });

  final Widget child;
  final VoidCallback onTap;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip ?? '',
      child: Material(
        color: AuthTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AuthTheme.onBackground.withValues(alpha: 0.08),
              ),
            ),
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}

class AuthSocialRow extends StatelessWidget {
  const AuthSocialRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AuthSocialIconButton(
            tooltip: 'Google',
            onTap: () {},
            child: const AppAssetImage(asset: AppAssets.google, width: 28, height: 28),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: AuthSocialIconButton(
            tooltip: 'Facebook',
            onTap: () {},
            child: const AppAssetImage(asset: AppAssets.facebook, width: 24, height: 24),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: AuthSocialIconButton(
            tooltip: 'Instagram',
            onTap: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: const AppAssetImage(
                asset: AppAssets.instagram,
                width: 22,
                height: 22,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: AuthSocialIconButton(
            tooltip: 'Apple',
            onTap: () {},
            child: Icon(Icons.apple, size: 24, color: AuthTheme.onSurface),
          ),
        ),
      ],
    );
  }
}

class AuthSocialSignupRow extends StatelessWidget {
  const AuthSocialSignupRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _LabeledSocialButton(
            icon: const AppAssetImage(asset: AppAssets.google, width: 22, height: 22),
            label: 'Google',
            onTap: () {},
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _LabeledSocialButton(
            icon: const AppAssetImage(asset: AppAssets.facebook, width: 20, height: 20),
            label: 'Facebook',
            onTap: () {},
          ),
        ),
      ],
    );
  }
}

class _LabeledSocialButton extends StatelessWidget {
  const _LabeledSocialButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final Widget icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AuthTheme.surfaceContainerLowest,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AuthTheme.outlineVariant),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(width: 8),
              Text(label, style: AuthTheme.labelMd(context, color: AuthTheme.onSurface)),
            ],
          ),
        ),
      ),
    );
  }
}
