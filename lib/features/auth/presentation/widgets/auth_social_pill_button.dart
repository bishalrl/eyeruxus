import 'package:eye_rex_us/core/constants/app_assets.dart';
import 'package:eye_rex_us/shared/widgets/app_asset_image.dart';
import 'package:eye_rex_us/features/auth/presentation/theme/auth_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Pill-shaped social login button from the eRupai login mockup.
class AuthSocialPillButton extends StatelessWidget {
  const AuthSocialPillButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.enabled = true,
  });

  final String label;
  final Widget icon;
  final VoidCallback? onPressed;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: enabled ? onPressed : null,
        borderRadius: BorderRadius.circular(999),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: AuthTheme.brandBorder.withValues(alpha: 0.6)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 28, height: 28, child: Center(child: icon)),
              const SizedBox(width: 12),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: enabled ? AuthTheme.onSurface : AuthTheme.brandMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AuthSocialBrandIcon extends StatelessWidget {
  const AuthSocialBrandIcon.google({super.key}) : _type = _Brand.google;
  const AuthSocialBrandIcon.apple({super.key}) : _type = _Brand.apple;
  const AuthSocialBrandIcon.instagram({super.key}) : _type = _Brand.instagram;
  const AuthSocialBrandIcon.facebook({super.key}) : _type = _Brand.facebook;

  final _Brand _type;

  @override
  Widget build(BuildContext context) {
    return switch (_type) {
      _Brand.google => const AppAssetImage(
          asset: AppAssets.google,
          width: 26,
          height: 26,
        ),
      _Brand.apple => const Icon(Icons.apple, size: 26, color: Colors.black),
      _Brand.instagram => ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: const AppAssetImage(
            asset: AppAssets.instagram,
            width: 26,
            height: 26,
            fit: BoxFit.cover,
          ),
        ),
      _Brand.facebook => const AppAssetImage(
          asset: AppAssets.facebook,
          width: 26,
          height: 26,
        ),
    };
  }
}

enum _Brand { google, apple, instagram, facebook }
