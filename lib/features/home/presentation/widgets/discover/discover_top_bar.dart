import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:eye_rex_us/features/home/presentation/theme/home_colors.dart';
import 'package:flutter/material.dart';

enum DiscoverFeedTab { following, square, video }

class DiscoverTopBar extends StatelessWidget {
  const DiscoverTopBar({
    super.key,
    required this.selectedTab,
    required this.onTabChanged,
  });

  final DiscoverFeedTab selectedTab;
  final ValueChanged<DiscoverFeedTab> onTabChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final tabs = <(DiscoverFeedTab, String)>[
      (DiscoverFeedTab.following, l10n.homeTabFollowing),
      (DiscoverFeedTab.square, l10n.discoverTabSquare),
      (DiscoverFeedTab.video, l10n.discoverTabVideo),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 12, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                for (var i = 0; i < tabs.length; i++) ...[
                  if (i > 0) const SizedBox(width: 20),
                  _DiscoverHeaderTab(
                    label: tabs[i].$2,
                    isSelected: selectedTab == tabs[i].$1,
                    onTap: () => onTabChanged(tabs[i].$1),
                  ),
                ],
              ],
            ),
          ),
          _GlobalChip(label: l10n.homeTabGlobal),
          const SizedBox(width: 8),
          _NotificationBell(onPressed: () {}),
        ],
      ),
    );
  }
}

class _DiscoverHeaderTab extends StatelessWidget {
  const _DiscoverHeaderTab({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isSelected ? HomeColors.accentAmber : HomeColors.textWhite,
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: isSelected ? 28 : 0,
            height: 3,
            decoration: BoxDecoration(
              color: HomeColors.accentAmber,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlobalChip extends StatelessWidget {
  const _GlobalChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: HomeColors.transparentTabBackground,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: HomeColors.textWhite.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.public, color: HomeColors.textWhite, size: 14),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: HomeColors.textWhite,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Icon(Icons.arrow_drop_down, color: HomeColors.textWhite, size: 16),
        ],
      ),
    );
  }
}

class _NotificationBell extends StatelessWidget {
  const _NotificationBell({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: HomeColors.iconButtonYellow,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: const SizedBox(
          width: 36,
          height: 36,
          child: Icon(
            Icons.notifications_none_outlined,
            color: HomeColors.textWhite,
            size: 20,
          ),
        ),
      ),
    );
  }
}
