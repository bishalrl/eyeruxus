import 'package:flutter/material.dart';

/// Home dashboard palette — warm orange/yellow theme from the design mockup.
abstract final class HomeColors {
  // Base
  static const backgroundBlack = Color(0xFF1A1A1A);
  static const textWhite = Color(0xFFFFFFFF);
  static const textGrey = Color(0xFFE8E8E8);
  static const textDark = Color(0xFF212121);

  // Main page gradient (orange → yellow)
  static const gradientOrange = Color(0xFFFF5722);
  static const gradientYellow = Color(0xFFFFC107);
  static const gradientOrangeDeep = Color(0xFFE64A19);

  // Accents
  static const accentAmber = Color(0xFFFFD600);
  static const accentOrange = Color(0xFFFF7043);
  static const iconButtonYellow = Color(0xFFFFCA28);
  static const transparentTabBackground = Color(0x40FFFFFF);

  // Bottom nav — white bar, orange active
  static const navBackground = Color(0xFFFFFFFF);
  static const navActiveItem = Color(0xFFFF7043);
  static const navInactiveItem = Color(0xFF9E9E9E);

  // Hall of Fame — blue/purple card only
  static const bannerGradientStart = Color(0xFF1A237E);
  static const bannerGradientEnd = Color(0xFF3F51B5);
  static const shadowColor = Color(0x40000000);

  // Search
  static const searchBarBackground = Color(0x66BF360C);

  // Live cards
  static const cardBackground = Color(0xFF1E1E1E);
  static const tagChatting = Color(0xFF2196F3);
  static const tagFriends = Color(0xFF4CAF50);
  static const tagTop10 = Color(0xFFF44336);
  static const tagNew = Color(0xFFFF9800);
  static const tagNearby = Color(0xFF9C27B0);
  static const pkBadge = Color(0xFFFFC107);

  // Other tabs
  static const partyAccent = Color(0xFFFF7043);
  static const discoverAccent = Color(0xFF4CAF50);
  static const profileCard = Color(0xFF2A2A2A);

  /// Full-screen warm gradient used on Live / Party / Discover / Profile headers.
  static const pageGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [gradientOrange, gradientYellow],
  );

  /// Go Live floating button.
  static const goLiveGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [gradientOrange, gradientYellow],
  );

  /// Hall of Fame promotional card — keeps blue/purple per design.
  static const hallOfFameGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [bannerGradientStart, bannerGradientEnd],
  );

  @Deprecated('Use pageGradient')
  static const headerGradient = pageGradient;

  @Deprecated('Use gradientOrange')
  static const primaryGradientStart = gradientOrange;

  @Deprecated('Use gradientYellow')
  static const primaryGradientEnd = gradientYellow;
}
