import 'package:eye_rex_us/features/home/domain/entities/reel_post.dart';
import 'package:eye_rex_us/features/home/presentation/theme/home_colors.dart';
import 'package:flutter/material.dart';

class ReelsTopTabs extends StatelessWidget {
  const ReelsTopTabs({
    super.key,
    required this.selected,
    required this.followingLabel,
    required this.forYouLabel,
    required this.onChanged,
  });

  final ReelsFeedTab selected;
  final String followingLabel;
  final String forYouLabel;
  final ValueChanged<ReelsFeedTab> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _TabChip(
          label: followingLabel,
          isSelected: selected == ReelsFeedTab.following,
          onTap: () => onChanged(ReelsFeedTab.following),
        ),
        const SizedBox(width: 24),
        _TabChip(
          label: forYouLabel,
          isSelected: selected == ReelsFeedTab.forYou,
          onTap: () => onChanged(ReelsFeedTab.forYou),
        ),
      ],
    );
  }
}

class _TabChip extends StatelessWidget {
  const _TabChip({
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isSelected ? HomeColors.textWhite : Colors.white60,
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: isSelected ? 24 : 0,
            height: 2,
            decoration: BoxDecoration(
              color: HomeColors.textWhite,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ],
      ),
    );
  }
}
