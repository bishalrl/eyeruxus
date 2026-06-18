import 'package:eye_rex_us/core/constants/app_assets.dart';
import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:eye_rex_us/core/utils/helper.dart';
import 'package:eye_rex_us/core/utils/responsive_layout.dart';
import 'package:eye_rex_us/features/home/presentation/theme/home_colors.dart';
import 'package:eye_rex_us/shared/widgets/app_asset_image.dart';
import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: ResponsiveLayout.isTablet(context) ? 28 : 22,
            backgroundColor: HomeColors.transparentTabBackground,
            backgroundImage: const AssetImage(AppAssets.avatar),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  TimeHelper.getGreeting(l10n),
                  style: TextStyle(
                    color: HomeColors.textWhite,
                    fontSize: ResponsiveLayout.getResponsiveFontSize(context, 20),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  l10n.homeProfileName,
                  style: TextStyle(
                    color: HomeColors.textWhite.withValues(alpha: 0.9),
                    fontSize: ResponsiveLayout.getResponsiveFontSize(context, 14),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          _YellowAssetButton(
            asset: AppAssets.camera,
            onPressed: () {},
          ),
          _NotificationButton(onPressed: () {}),
        ],
      ),
    );
  }
}

class _NotificationButton extends StatelessWidget {
  const _NotificationButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Material(
        color: HomeColors.iconButtonYellow,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: SizedBox(
            width: 40,
            height: 40,
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(
                  Icons.notifications_none_outlined,
                  color: HomeColors.textWhite,
                  size: 22,
                ),
                Positioned(
                  top: 9,
                  right: 10,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: HomeColors.accentAmber,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _YellowAssetButton extends StatelessWidget {
  const _YellowAssetButton({required this.asset, required this.onPressed});

  final String asset;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Material(
        color: HomeColors.iconButtonYellow,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: SizedBox(
            width: 40,
            height: 40,
            child: Padding(
              padding: const EdgeInsets.all(9),
              child: AppAssetImage(asset: asset, color: HomeColors.textWhite),
            ),
          ),
        ),
      ),
    );
  }
}
