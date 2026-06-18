import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:eye_rex_us/features/home/presentation/navigation/home_live_routes.dart';
import 'package:eye_rex_us/features/home/presentation/theme/home_colors.dart';
import 'package:flutter/material.dart';

/// Quick access row to all LiveScreens from the home feed (no legacy UI edits).
class HomeLiveQuickStrip extends StatelessWidget {
  const HomeLiveQuickStrip({super.key});

  @override
  Widget build(BuildContext context) {
    final items = HomeLiveRoutes.all(context.l10n);

    return SizedBox(
      height: 88,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final item = items[index];
          return Material(
            color: HomeColors.cardBackground,
            borderRadius: BorderRadius.circular(14),
            child: InkWell(
              onTap: () => item.open(context),
              borderRadius: BorderRadius.circular(14),
              child: SizedBox(
                width: 88,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item.icon, color: HomeColors.accentOrange, size: 26),
                    const SizedBox(height: 6),
                    Text(
                      item.label,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: HomeColors.textWhite,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
