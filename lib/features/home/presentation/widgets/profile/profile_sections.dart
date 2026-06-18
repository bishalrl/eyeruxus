import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:eye_rex_us/features/home/presentation/bloc/profile_page_cubit.dart';
import 'package:eye_rex_us/features/home/presentation/navigation/profile_routes.dart';
import 'package:eye_rex_us/features/home/presentation/theme/profile_theme.dart';
import 'package:flutter/material.dart';

class ProfileHeaderSection extends StatelessWidget {
  const ProfileHeaderSection({super.key, required this.data});

  final ProfileViewData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
      child: Column(
        children: [
          CircleAvatar(
            radius: 44,
            backgroundColor: ProfileTheme.avatarBrown,
            child: Text(
              data.initial,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            data.displayName,
            style: const TextStyle(
              color: ProfileTheme.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            context.l10n.profileUserId(data.userId),
            style: const TextStyle(
              color: ProfileTheme.textPrimary,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _BadgePill(
                icon: Icons.male,
                label: '${data.age}',
              ),
              const SizedBox(width: 8),
              _BadgePill(
                icon: Icons.diamond_outlined,
                label: '${data.diamonds}',
              ),
              const SizedBox(width: 8),
              _BadgePill(
                icon: Icons.shield_outlined,
                label: '${data.shieldLevel}',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BadgePill extends StatelessWidget {
  const _BadgePill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: ProfileTheme.badgeBlue,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: ProfileTheme.badgeIconBlue),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: ProfileTheme.textPrimary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileStatsRow extends StatelessWidget {
  const ProfileStatsRow({super.key, required this.data});

  final ProfileViewData data;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: _StatColumn(value: '${data.friends}', label: l10n.profileFriends),
          ),
          Expanded(
            child: _StatColumn(value: '${data.following}', label: l10n.homeFollowing),
          ),
          Expanded(
            child: _StatColumn(value: '${data.followers}', label: l10n.homeFollowers),
          ),
        ],
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  const _StatColumn({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: ProfileTheme.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            color: ProfileTheme.textSecondary,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class ProfileWalletCards extends StatelessWidget {
  const ProfileWalletCards({
    super.key,
    required this.coins,
    required this.points,
    required this.onTopUp,
    required this.onWithdraw,
  });

  final int coins;
  final int points;
  final VoidCallback onTopUp;
  final VoidCallback onWithdraw;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _WalletCard(
              title: l10n.profileCoins,
              value: '$coins',
              actionLabel: l10n.profileTopUp,
              titleColor: ProfileTheme.coinsAccent,
              actionColor: ProfileTheme.coinsAccent,
              onAction: onTopUp,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _WalletCard(
              title: l10n.profilePoints,
              value: '$points',
              actionLabel: l10n.profileWithdraw,
              titleColor: ProfileTheme.pointsAccent,
              actionColor: ProfileTheme.pointsAccent,
              onAction: onWithdraw,
            ),
          ),
        ],
      ),
    );
  }
}

class _WalletCard extends StatelessWidget {
  const _WalletCard({
    required this.title,
    required this.value,
    required this.actionLabel,
    required this.titleColor,
    required this.actionColor,
    required this.onAction,
  });

  final String title;
  final String value;
  final String actionLabel;
  final Color titleColor;
  final Color actionColor;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: ProfileTheme.cardWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [ProfileTheme.cardShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: titleColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: ProfileTheme.textPrimary,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              height: 1,
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: onAction,
            child: Text(
              actionLabel,
              style: TextStyle(
                color: actionColor,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileVipBanner extends StatelessWidget {
  const ProfileVipBanner({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Material(
        color: ProfileTheme.vipBannerBg,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                Icon(Icons.workspace_premium, color: ProfileTheme.vipGold, size: 28),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    context.l10n.profileVipUpgrade,
                    style: const TextStyle(
                      color: ProfileTheme.textPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: ProfileTheme.textSecondary,
                  size: 22,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileQuickActionsGrid extends StatelessWidget {
  const ProfileQuickActionsGrid({super.key, required this.onItemTap});

  final void Function(ProfileQuickAction action) onItemTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final items = [
      (ProfileQuickAction.reward, Icons.card_giftcard, l10n.profileReward),
      (ProfileQuickAction.rank, Icons.emoji_events_outlined, l10n.profileRank),
      (ProfileQuickAction.store, Icons.storefront_outlined, l10n.homeProfileStore),
      (ProfileQuickAction.auth, Icons.verified_user_outlined, l10n.profileAuth),
      (ProfileQuickAction.vip, Icons.military_tech_outlined, l10n.profileVipShort),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (final item in items)
            _QuickActionItem(
              icon: item.$2,
              label: item.$3,
              onTap: () => onItemTap(item.$1),
            ),
        ],
      ),
    );
  }
}

enum ProfileQuickAction { reward, rank, store, auth, vip }

class _QuickActionItem extends StatelessWidget {
  const _QuickActionItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 62,
        child: Column(
          children: [
            Icon(icon, color: ProfileTheme.iconOrange, size: 28),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: ProfileTheme.textPrimary,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileHostRewardsBanner extends StatelessWidget {
  const ProfileHostRewardsBanner({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: ProfileTheme.promoOrange,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(
              l10n.profileHostRewardsTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              l10n.profileHostRewardsDate,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }
}

class ProfileMenuList extends StatelessWidget {
  const ProfileMenuList({
    super.key,
    required this.inviteReward,
    required this.onInvite,
    required this.onMyAgency,
    required this.onActivityCentre,
    required this.legacyItems,
    required this.onLogout,
  });

  final int inviteReward;
  final VoidCallback onInvite;
  final VoidCallback onMyAgency;
  final VoidCallback onActivityCentre;
  final List<ProfileLegacyMenuItem> legacyItems;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          _MenuTile(
            icon: Icons.mail_outline,
            label: l10n.profileInvite,
            trailing: Text(
              l10n.profileInviteReward('$inviteReward'),
              style: const TextStyle(
                color: ProfileTheme.inviteReward,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: onInvite,
          ),
          _MenuTile(
            icon: Icons.groups_outlined,
            label: l10n.profileMyAgency,
            onTap: onMyAgency,
          ),
          _MenuTile(
            icon: Icons.event_note_outlined,
            label: l10n.profileActivityCentre,
            onTap: onActivityCentre,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Divider(color: ProfileTheme.divider, height: 1),
          ),
          for (final item in legacyItems)
            _MenuTile(
              icon: item.icon,
              label: item.label,
              onTap: item.onTap,
            ),
          const SizedBox(height: 4),
          _MenuTile(
            icon: Icons.logout,
            label: l10n.homeProfileLogout,
            labelColor: ProfileTheme.coinsAccent,
            iconColor: ProfileTheme.coinsAccent,
            onTap: onLogout,
            showChevron: false,
          ),
        ],
      ),
    );
  }
}

class ProfileLegacyMenuItem {
  const ProfileLegacyMenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.trailing,
    this.labelColor = ProfileTheme.textPrimary,
    this.iconColor = ProfileTheme.iconOrange,
    this.showChevron = true,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Widget? trailing;
  final Color labelColor;
  final Color iconColor;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Row(
            children: [
              Icon(icon, color: iconColor, size: 22),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: labelColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (trailing != null) ...[
                trailing!,
                const SizedBox(width: 4),
              ],
              if (showChevron)
                const Icon(
                  Icons.chevron_right,
                  color: ProfileTheme.textSecondary,
                  size: 22,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
