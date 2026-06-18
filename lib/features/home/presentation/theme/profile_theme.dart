import 'package:flutter/material.dart';

/// Light peach profile tab palette — matches the design mockup.
abstract final class ProfileTheme {
  static const background = Color(0xFFFFF1E1);
  static const avatarBrown = Color(0xFF8B5E3C);
  static const textPrimary = Color(0xFF212121);
  static const textSecondary = Color(0xFF757575);
  static const badgeBlue = Color(0xFFE3F2FD);
  static const badgeIconBlue = Color(0xFF42A5F5);
  static const coinsAccent = Color(0xFFFF7043);
  static const pointsAccent = Color(0xFFE91E63);
  static const vipBannerBg = Color(0xFFFFF9C4);
  static const vipGold = Color(0xFFFFB300);
  static const iconOrange = Color(0xFFFF7043);
  static const promoOrange = Color(0xFFFF5722);
  static const cardWhite = Colors.white;
  static const divider = Color(0xFFEEEEEE);
  static const inviteReward = Color(0xFFFF7043);

  static const cardShadow = BoxShadow(
    color: Color(0x14000000),
    blurRadius: 8,
    offset: Offset(0, 2),
  );
}
