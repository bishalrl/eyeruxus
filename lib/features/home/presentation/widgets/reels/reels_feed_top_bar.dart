import 'package:eye_rex_us/features/home/domain/entities/reel_post.dart';
import 'package:eye_rex_us/features/home/presentation/theme/home_colors.dart';
import 'package:eye_rex_us/features/home/presentation/widgets/reels/reels_top_tabs.dart';
import 'package:flutter/material.dart';

class ReelsFeedTopBar extends StatelessWidget {
  const ReelsFeedTopBar({
    super.key,
    required this.selectedTab,
    required this.followingLabel,
    required this.forYouLabel,
    required this.onTabChanged,
    required this.onBack,
  });

  final ReelsFeedTab selectedTab;
  final String followingLabel;
  final String forYouLabel;
  final ValueChanged<ReelsFeedTab> onTabChanged;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xCC000000),
            Color(0x66000000),
            Colors.transparent,
          ],
          stops: [0, 0.55, 1],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 52,
          child: Row(
            children: [
              IconButton(
                onPressed: onBack,
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: HomeColors.textWhite,
                  size: 22,
                ),
              ),
              Expanded(
                child: ReelsTopTabs(
                  selected: selectedTab,
                  followingLabel: followingLabel,
                  forYouLabel: forYouLabel,
                  onChanged: onTabChanged,
                ),
              ),
              const SizedBox(width: 48),
            ],
          ),
        ),
      ),
    );
  }
}
