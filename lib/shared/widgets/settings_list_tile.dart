import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class SettingsListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool showArrow;
  final bool showBadge;

  const SettingsListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.showArrow = true,
    this.showBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: textTheme.titleMedium?.copyWith(
                color: colors.settingsItemText,
              ),
            ),
          ),
          if (subtitle != null)
            Text(
              subtitle!,
              style: textTheme.bodyMedium?.copyWith(
                color: colors.settingsSubtitle,
              ),
            ),
          const SizedBox(width: 8),
          if (showBadge)
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: colors.settingsDanger,
                shape: BoxShape.circle,
              ),
            ),
          if (showBadge) const SizedBox(width: 8),
          if (showArrow)
            Icon(Icons.arrow_forward_ios, size: 14, color: colors.textMuted),
        ],
      ),
    );
  }
}
