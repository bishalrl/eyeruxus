import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';

abstract final class AppTheme {
  static ThemeData light() => _build(Brightness.light, AppColors.light);

  static ThemeData dark() => _build(Brightness.dark, AppColors.dark);

  static ThemeData _build(Brightness brightness, AppColors colors) {
    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: colors.primary,
      onPrimary: colors.onPrimary,
      secondary: colors.secondary,
      onSecondary: colors.onSecondary,
      error: colors.error,
      onError: colors.onPrimary,
      surface: colors.surface,
      onSurface: colors.textPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colors.scaffoldBackground,
      textTheme: AppTypography.textTheme(brightness),
      appBarTheme: AppBarTheme(
        backgroundColor: colors.surface,
        foregroundColor: colors.textPrimary,
        elevation: 0,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          elevation: 0,
        ),
      ),
      extensions: [colors],
      dividerColor: colors.border,
      iconTheme: IconThemeData(color: colors.textPrimary),
    );
  }
}
