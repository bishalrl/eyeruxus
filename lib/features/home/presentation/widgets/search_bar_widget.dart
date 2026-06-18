import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:eye_rex_us/features/home/presentation/theme/home_colors.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          color: HomeColors.searchBarBackground,
          borderRadius: BorderRadius.circular(25),
        ),
        child: TextField(
          textAlign: TextAlign.center,
          style: const TextStyle(color: HomeColors.textWhite),
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search, color: HomeColors.textGrey),
            hintText: l10n.homeSearchHint,
            hintStyle: const TextStyle(color: HomeColors.textGrey, fontSize: 14),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
          ),
        ),
      ),
    );
  }
}
