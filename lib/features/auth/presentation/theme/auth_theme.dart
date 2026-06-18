import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Auth design tokens — eRupai login + StreamLive signup flows.
abstract final class AuthTheme {
  static const primary = Color(0xFF6B38D4);
  static const secondary = Color(0xFFB4136D);
  static const secondaryContainer = Color(0xFFFD56A7);
  static const onBackground = Color(0xFF121C2A);
  static const onSurface = Color(0xFF121C2A);
  static const onSurfaceVariant = Color(0xFF494454);
  static const outline = Color(0xFF7B7486);
  static const outlineVariant = Color(0xFFCBC3D7);
  static const surfaceContainerLow = Color(0xFFEFF4FF);
  static const surfaceContainerLowest = Color(0xFFFFFFFF);
  static const background = Color(0xFFFFFFFF);
  static const onPrimary = Color(0xFFFFFFFF);
  static const error = Color(0xFFBA1A1A);
  static const errorContainer = Color(0xFFFFDAD6);

  // eRupai login screen
  static const brandPeach = Color(0xFFF5D0CC);
  static const brandAccent = Color(0xFFD94F6A);
  static const brandRed = Color(0xFFE53935);
  static const brandBlue = Color(0xFF1565C0);
  static const brandGold = Color(0xFFF9A825);
  static const brandMuted = Color(0xFF9E9E9E);
  static const brandBorder = Color(0xFFBDBDBD);

  // Gradient form screens (registration, forgot password, OTP)
  static const formGradientStart = Color(0xFFE8913A);
  static const formGradientEnd = Color(0xFFF5C4A8);
  static const formLabel = Color(0xFFB5651D);
  static const formTeal = Color(0xFF00D9B5);
  static const formGenderSelected = Color(0xFF2196F3);
  static const formGenderUnselected = Color(0xFFF0F0F0);
  static const formDivider = Color(0xFFE0E0E0);
  static const formFooterNote = Color(0xFFB0B0B0);

  static const formHeaderGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [formGradientStart, formGradientEnd],
  );

  static const gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, secondaryContainer],
  );

  static TextStyle displayLg(BuildContext context) =>
      GoogleFonts.sora(
        fontSize: 48,
        height: 1.1,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.02 * 48,
        color: onBackground,
      );

  static TextStyle headlineMd(BuildContext context) =>
      GoogleFonts.sora(
        fontSize: 24,
        height: 1.3,
        fontWeight: FontWeight.w600,
        color: onBackground,
      );

  static TextStyle bodyLg(BuildContext context) =>
      GoogleFonts.hankenGrotesk(
        fontSize: 18,
        height: 1.6,
        fontWeight: FontWeight.w400,
        color: onSurfaceVariant,
      );

  static TextStyle bodyMd(BuildContext context) =>
      GoogleFonts.hankenGrotesk(
        fontSize: 16,
        height: 1.6,
        fontWeight: FontWeight.w400,
        color: onSurface,
      );

  static TextStyle labelMd(BuildContext context, {Color? color}) =>
      GoogleFonts.hankenGrotesk(
        fontSize: 14,
        height: 1.0,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.05 * 14,
        color: color ?? onSurfaceVariant,
      );

  static TextStyle sectionTitle(BuildContext context) =>
      GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: brandAccent,
      );

  static TextStyle captionMuted(BuildContext context) =>
      GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: brandMuted,
      );

  static TextStyle bodySm(BuildContext context, {Color? color}) =>
      GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: color ?? onSurface,
        height: 1.4,
      );
}
