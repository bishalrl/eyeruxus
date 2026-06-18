import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:eye_rex_us/features/home/presentation/theme/home_colors.dart';
import 'package:flutter/material.dart';

/// Slightly elevated center-docked FAB — matches the reference notch position.
class GoLiveFabLocation extends FloatingActionButtonLocation {
  const GoLiveFabLocation();

  static const _lift = 25.0;

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final fabSize = scaffoldGeometry.floatingActionButtonSize;
    final fabX =
        (scaffoldGeometry.scaffoldSize.width - fabSize.width) / 2.0;
    final fabY = scaffoldGeometry.contentBottom -
        fabSize.height / 2.0 -
        _lift;
    return Offset(fabX, fabY);
  }
}

/// Tab row for [BottomAppBar] — Go Live uses [Scaffold.floatingActionButton].
class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const _iconSize = 22.0;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final items = <(IconData, String, int)>[
      (Icons.videocam_outlined, l10n.homeNavLive, 0),
      (Icons.people_outline, l10n.homeNavParty, 1),
      (Icons.explore_outlined, l10n.homeNavDiscover, 2),
      (Icons.chat_bubble_outline, l10n.homeNavChat, 3),
      (Icons.person_outline, l10n.homeNavProfile, 4),
    ];

    return Row(
      children: [
        for (final item in items)
          Expanded(
            child: _NavItem(
              icon: item.$1,
              label: item.$2,
              isSelected: currentIndex == item.$3,
              onTap: () => onTap(item.$3),
            ),
          ),
      ],
    );
  }
}

class GoLiveFab extends StatelessWidget {
  const GoLiveFab({super.key, this.onTap});

  final VoidCallback? onTap;

  static const _size = 50.0;

  @override
  Widget build(BuildContext context) {
    final label = context.l10n.homeNavGoLive;

    return SizedBox(
      width: _size,
      height: _size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: HomeColors.goLiveGradient,
          boxShadow: const [
            BoxShadow(
              color: Color(0x4DFF5722),
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            customBorder: const CircleBorder(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.videocam,
                  color: HomeColors.textWhite,
                  size: _size * 0.36,
                ),
                const SizedBox(height: 1),
                Text(
                  label,
                  style: const TextStyle(
                    color: HomeColors.textWhite,
                    fontSize: 8,
                    height: 1,
                    fontWeight: FontWeight.w600,
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

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color =
        isSelected ? HomeColors.navActiveItem : HomeColors.navInactiveItem;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: CustomBottomNavBar._iconSize),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 10,
                height: 1,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
