import 'package:eye_rex_us/core/constants/app_assets.dart';
import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:eye_rex_us/features/home/presentation/theme/home_colors.dart';
import 'package:eye_rex_us/shared/widgets/app_asset_image.dart';
import 'package:flutter/material.dart';

class HallOfFameBanner extends StatelessWidget {
  const HallOfFameBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: HomeColors.hallOfFameGradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: HomeColors.shadowColor,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const AppAssetImage(
                        asset: AppAssets.trophy,
                        width: 18,
                        height: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        l10n.homeHallOfFameTitle,
                        style: const TextStyle(
                          color: HomeColors.textWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.homeHallOfFameSubtitle,
                    style: const TextStyle(
                      color: HomeColors.textWhite,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const AppAssetImage(asset: AppAssets.trophy, width: 50, height: 50),
          ],
        ),
      ),
    );
  }
}
