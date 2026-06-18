import 'package:eye_rex_us/core/constants/app_assets.dart';
import 'package:eye_rex_us/features/auth/presentation/theme/auth_theme.dart';
import 'package:eye_rex_us/shared/widgets/app_asset_image.dart';
import 'package:flutter/material.dart';

/// Circular profile placeholder with camera badge (registration header).
class AuthProfileAvatarPicker extends StatelessWidget {
  const AuthProfileAvatarPicker({
    super.key,
    this.onTap,
    this.radius = 36,
  });

  final VoidCallback? onTap;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final size = radius * 2;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const AppAssetImage(
                asset: AppAssets.avatarPlaceholder,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              right: -2,
              bottom: -2,
              child: Container(
                width: 26,
                height: 26,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AuthTheme.formGradientStart,
                ),
                padding: const EdgeInsets.all(5),
                child: const AppAssetImage(asset: AppAssets.camera),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
