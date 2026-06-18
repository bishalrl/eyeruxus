import 'package:flutter/material.dart';

/// Raw design tokens. Never reference directly from widgets — use [AppColors].
abstract final class AppPalette {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF111212);
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey200 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey800 = Color(0xFF424242);
  static const Color orange = Color(0xFFFF9800);
  static const Color red = Color(0xFFF44336);
  static const Color blue = Color(0xFF2196F3);
  static const Color indigo = Color(0xFF5B6FED);
  static const Color purple = Color(0xFF7E45FF);
  static const Color liveRed = Color(0xFFAF1D18);
  static const Color liveRedLight = Color(0xFFCD6866);
  static const Color liveSeatOccupied = Color(0xFFD64041);
  static const Color liveSeatEmpty = Color(0xFFE0BEBF);
  static const Color storeGold = Color(0xFFFDD525);
  static const Color mallPurple = Color(0xFF8263FF);
  static const Color mallPurpleLight = Color(0xFF9B7BF5);
  static const Color mallLavender = Color(0xFFF0E9FF);
  static const Color vipBlue = Color(0xFF4299E1);
  static const Color guardianBrown = Color(0xFF4A3728);
  static const Color guardianBrownDark = Color(0xFF2B1F17);
}
