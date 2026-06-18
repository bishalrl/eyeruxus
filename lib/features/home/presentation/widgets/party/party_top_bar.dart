import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:eye_rex_us/features/home/domain/entities/party_feed_tab.dart';
import 'package:eye_rex_us/features/home/presentation/theme/home_colors.dart';
import 'package:flutter/material.dart';

class PartyTopBar extends StatelessWidget {
  const PartyTopBar({
    super.key,
    required this.selectedTab,
    required this.onTabChanged,
  });

  final PartyFeedTab selectedTab;
  final ValueChanged<PartyFeedTab> onTabChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final tabs = <(PartyFeedTab, String)>[
      (PartyFeedTab.hot, l10n.homePartyTabHot),
      (PartyFeedTab.nearby, l10n.homePartyTabNearby),
      (PartyFeedTab.friends, l10n.homePartyTabFriends),
      (PartyFeedTab.private, l10n.homePartyTabPrivate),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Row(
        children: [
          for (var i = 0; i < tabs.length; i++) ...[
            if (i > 0) const SizedBox(width: 8),
            _PartyTabChip(
              label: tabs[i].$2,
              selected: selectedTab == tabs[i].$1,
              onTap: () => onTabChanged(tabs[i].$1),
            ),
          ],
        ],
      ),
    );
  }
}

class _PartyTabChip extends StatelessWidget {
  const _PartyTabChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? HomeColors.textWhite : HomeColors.transparentTabBackground,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            label,
            style: TextStyle(
              color: selected ? HomeColors.partyAccent : HomeColors.textWhite,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}
