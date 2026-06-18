import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:eye_rex_us/features/home/domain/entities/home_feed_tab.dart';
import 'package:eye_rex_us/features/home/presentation/bloc/home_bloc.dart';
import 'package:eye_rex_us/features/home/presentation/bloc/home_event.dart';
import 'package:eye_rex_us/features/home/presentation/bloc/home_state.dart';
import 'package:eye_rex_us/features/home/presentation/theme/home_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionTabsSection extends StatelessWidget {
  const ActionTabsSection({super.key});

  static const _horizontalPadding = 16.0;
  static const _tabGap = 8.0;
  static const _tabHeight = 36.0;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          current is HomeLoadedState ||
          current is HomeLoadingState ||
          previous.runtimeType != current.runtimeType,
      builder: (context, state) {
        final selectedTab = switch (state) {
          HomeLoadedState s => s.selectedTab,
          HomeLoadingState s => s.tab,
          _ => HomeFeedTab.explore,
        };

        final tabs = <(HomeFeedTab, String)>[
          (HomeFeedTab.following, l10n.homeTabFollowing),
          (HomeFeedTab.explore, l10n.homeTabExplore),
          (HomeFeedTab.newTab, l10n.homeTabNew),
          (HomeFeedTab.nearby, l10n.homeTabNearby),
        ];

        return Padding(
          padding: const EdgeInsets.fromLTRB(
            _horizontalPadding,
            6,
            _horizontalPadding,
            10,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  children: [
                    for (var i = 0; i < tabs.length; i++) ...[
                      if (i > 0) const SizedBox(width: _tabGap),
                      Expanded(
                        child: _FeedTabPill(
                          label: tabs[i].$2,
                          isSelected: selectedTab == tabs[i].$1,
                          showTrophy: tabs[i].$1 == HomeFeedTab.nearby,
                          onTap: () => context.read<HomeBloc>().add(
                                ChangeHomeFeedTabEvent(tabs[i].$1),
                              ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 10),
              _GlobalFilterPill(label: l10n.homeTabGlobal),
            ],
          ),
        );
      },
    );
  }
}

class _FeedTabPill extends StatelessWidget {
  const _FeedTabPill({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.showTrophy = false,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool showTrophy;

  @override
  Widget build(BuildContext context) {
    final contentColor =
        isSelected ? HomeColors.textDark : HomeColors.textWhite;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: ActionTabsSection._tabHeight,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: isSelected
                ? HomeColors.accentAmber
                : HomeColors.transparentTabBackground,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isSelected
                  ? HomeColors.accentAmber
                  : HomeColors.textWhite.withValues(alpha: 0.35),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (showTrophy) ...[
                Icon(
                  Icons.emoji_events_outlined,
                  size: 14,
                  color: contentColor,
                ),
                const SizedBox(width: 3),
              ],
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: contentColor,
                    fontSize: 12,
                    height: 1.1,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GlobalFilterPill extends StatelessWidget {
  const _GlobalFilterPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ActionTabsSection._tabHeight,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: HomeColors.transparentTabBackground,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: HomeColors.textWhite.withValues(alpha: 0.35),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.public, color: HomeColors.textWhite, size: 14),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: HomeColors.textWhite,
              fontSize: 12,
              height: 1.1,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Icon(Icons.arrow_drop_down, color: HomeColors.textWhite, size: 16),
        ],
      ),
    );
  }
}
