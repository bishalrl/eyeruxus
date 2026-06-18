import 'package:flutter/material.dart';

import 'app_palette.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.scaffoldBackground,
    required this.surface,
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.border,
    required this.success,
    required this.warning,
    required this.error,
    required this.info,
    required this.liveBackground,
    required this.liveAccent,
    required this.liveSeatOccupied,
    required this.liveSeatEmpty,
    required this.storeGold,
    required this.mallPrimary,
    required this.mallSecondary,
    required this.mallCard,
    required this.vipAccent,
    required this.guardianGradientStart,
    required this.guardianGradientEnd,
    required this.settingsBackground,
    required this.settingsItemText,
    required this.settingsSubtitle,
    required this.settingsAccent,
    required this.settingsDanger,
    required this.navLauncherTile,
    required this.navLauncherText,
  });

  final Color scaffoldBackground;
  final Color surface;
  final Color primary;
  final Color onPrimary;
  final Color secondary;
  final Color onSecondary;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color border;
  final Color success;
  final Color warning;
  final Color error;
  final Color info;
  final Color liveBackground;
  final Color liveAccent;
  final Color liveSeatOccupied;
  final Color liveSeatEmpty;
  final Color storeGold;
  final Color mallPrimary;
  final Color mallSecondary;
  final Color mallCard;
  final Color vipAccent;
  final Color guardianGradientStart;
  final Color guardianGradientEnd;
  final Color settingsBackground;
  final Color settingsItemText;
  final Color settingsSubtitle;
  final Color settingsAccent;
  final Color settingsDanger;
  final Color navLauncherTile;
  final Color navLauncherText;

  static const AppColors light = AppColors(
    scaffoldBackground: AppPalette.grey50,
    surface: AppPalette.white,
    primary: AppPalette.indigo,
    onPrimary: AppPalette.white,
    secondary: AppPalette.purple,
    onSecondary: AppPalette.white,
    textPrimary: AppPalette.black,
    textSecondary: AppPalette.grey800,
    textMuted: AppPalette.grey600,
    border: AppPalette.grey200,
    success: Color(0xFF22C55E),
    warning: AppPalette.orange,
    error: AppPalette.red,
    info: AppPalette.blue,
    liveBackground: AppPalette.liveRed,
    liveAccent: AppPalette.liveRedLight,
    liveSeatOccupied: AppPalette.liveSeatOccupied,
    liveSeatEmpty: AppPalette.liveSeatEmpty,
    storeGold: AppPalette.storeGold,
    mallPrimary: AppPalette.mallPurple,
    mallSecondary: AppPalette.mallPurpleLight,
    mallCard: AppPalette.mallLavender,
    vipAccent: AppPalette.vipBlue,
    guardianGradientStart: AppPalette.guardianBrown,
    guardianGradientEnd: AppPalette.guardianBrownDark,
    settingsBackground: AppPalette.grey50,
    settingsItemText: Color(0xDE000000),
    settingsSubtitle: AppPalette.grey600,
    settingsAccent: AppPalette.orange,
    settingsDanger: AppPalette.red,
    navLauncherTile: AppPalette.blue,
    navLauncherText: AppPalette.white,
  );

  static const AppColors dark = AppColors(
    scaffoldBackground: Color(0xFF121212),
    surface: Color(0xFF1E1E1E),
    primary: AppPalette.indigo,
    onPrimary: AppPalette.white,
    secondary: AppPalette.purple,
    onSecondary: AppPalette.white,
    textPrimary: Color(0xFFF5F5F5),
    textSecondary: Color(0xFFE0E0E0),
    textMuted: AppPalette.grey400,
    border: Color(0xFF2C2C2C),
    success: Color(0xFF22C55E),
    warning: AppPalette.orange,
    error: AppPalette.red,
    info: AppPalette.blue,
    liveBackground: AppPalette.liveRed,
    liveAccent: AppPalette.liveRedLight,
    liveSeatOccupied: AppPalette.liveSeatOccupied,
    liveSeatEmpty: AppPalette.liveSeatEmpty,
    storeGold: AppPalette.storeGold,
    mallPrimary: AppPalette.mallPurple,
    mallSecondary: AppPalette.mallPurpleLight,
    mallCard: Color(0xFF2A2438),
    vipAccent: AppPalette.vipBlue,
    guardianGradientStart: AppPalette.guardianBrown,
    guardianGradientEnd: AppPalette.guardianBrownDark,
    settingsBackground: Color(0xFF121212),
    settingsItemText: Color(0xFFF5F5F5),
    settingsSubtitle: AppPalette.grey400,
    settingsAccent: AppPalette.orange,
    settingsDanger: AppPalette.red,
    navLauncherTile: AppPalette.indigo,
    navLauncherText: AppPalette.white,
  );

  @override
  AppColors copyWith({
    Color? scaffoldBackground,
    Color? surface,
    Color? primary,
    Color? onPrimary,
    Color? secondary,
    Color? onSecondary,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? border,
    Color? success,
    Color? warning,
    Color? error,
    Color? info,
    Color? liveBackground,
    Color? liveAccent,
    Color? liveSeatOccupied,
    Color? liveSeatEmpty,
    Color? storeGold,
    Color? mallPrimary,
    Color? mallSecondary,
    Color? mallCard,
    Color? vipAccent,
    Color? guardianGradientStart,
    Color? guardianGradientEnd,
    Color? settingsBackground,
    Color? settingsItemText,
    Color? settingsSubtitle,
    Color? settingsAccent,
    Color? settingsDanger,
    Color? navLauncherTile,
    Color? navLauncherText,
  }) {
    return AppColors(
      scaffoldBackground: scaffoldBackground ?? this.scaffoldBackground,
      surface: surface ?? this.surface,
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      border: border ?? this.border,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      info: info ?? this.info,
      liveBackground: liveBackground ?? this.liveBackground,
      liveAccent: liveAccent ?? this.liveAccent,
      liveSeatOccupied: liveSeatOccupied ?? this.liveSeatOccupied,
      liveSeatEmpty: liveSeatEmpty ?? this.liveSeatEmpty,
      storeGold: storeGold ?? this.storeGold,
      mallPrimary: mallPrimary ?? this.mallPrimary,
      mallSecondary: mallSecondary ?? this.mallSecondary,
      mallCard: mallCard ?? this.mallCard,
      vipAccent: vipAccent ?? this.vipAccent,
      guardianGradientStart:
          guardianGradientStart ?? this.guardianGradientStart,
      guardianGradientEnd: guardianGradientEnd ?? this.guardianGradientEnd,
      settingsBackground: settingsBackground ?? this.settingsBackground,
      settingsItemText: settingsItemText ?? this.settingsItemText,
      settingsSubtitle: settingsSubtitle ?? this.settingsSubtitle,
      settingsAccent: settingsAccent ?? this.settingsAccent,
      settingsDanger: settingsDanger ?? this.settingsDanger,
      navLauncherTile: navLauncherTile ?? this.navLauncherTile,
      navLauncherText: navLauncherText ?? this.navLauncherText,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return t < 0.5 ? this : other;
  }
}
