import 'package:flutter/material.dart';

abstract final class HostMoneyTheme {
  static const background = Color(0xFFF5F0FF);
  static const accentPink = Color(0xFFE91E63);
  static const accentPurple = Color(0xFF9C27B0);

  static const sectionTitle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static const cardDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(12)),
  );
}
