import 'package:eye_rex_us/features/home/presentation/navigation/home_legacy_routes.dart';
import 'package:eye_rex_us/features/home/presentation/theme/home_colors.dart';
import 'package:flutter/material.dart';

class HomeLegacyMenuSection extends StatelessWidget {
  const HomeLegacyMenuSection({
    super.key,
    required this.title,
    required this.items,
  });

  final String title;
  final List<HomeLegacyMenuItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 8, 4, 12),
          child: Text(
            title,
            style: const TextStyle(
              color: HomeColors.textWhite,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 2.4,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Material(
              color: HomeColors.cardBackground,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                onTap: () => item.open(context),
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Row(
                    children: [
                      Icon(item.icon, color: HomeColors.accentOrange, size: 22),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          item.label,
                          style: const TextStyle(
                            color: HomeColors.textWhite,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
