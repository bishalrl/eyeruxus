import 'package:flutter/material.dart';

extension ColorSchemeExtension on ColorScheme {
  Color get appTransparent => Colors.transparent;

  Color get appWhite => Colors.white;

  Color get appBlack => const Color(0xFF111212);

  Color get appButtonTextColor =>
      brightness == Brightness.dark ? Colors.white : Colors.black;

  Color get appBottomColor =>
      brightness == Brightness.dark ? Colors.black : Colors.white;

  Color get appBackGroundColor => brightness == Brightness.dark
      ? const Color(0xFF121212)
      : const Color(0xFFFFFFFF);

  Color get unselectedColors => brightness == Brightness.dark
      ? const Color(0xFFABABAB)
      : const Color(0xFFABABAB);

  Color get appbarIconColor => brightness == Brightness.dark
      ? const Color(0xFFF5F5F5)
      : const Color(0xFF121212);

  Color get icSeeAllBg => brightness == Brightness.dark
      ? const Color(0xFF121212)
      : const Color(0xFF777777).withOpacity(0.3);

  Color get appHeadingColor => brightness == Brightness.dark
      ? const Color(0xFFF5F5F5)
      : const Color(0xFF121212);

  Color get appBodyColor => brightness == Brightness.dark
      ? const Color(0xFFF5F5F5)
      : const Color(0xFF121212);

  Color get appTextFieldColor => brightness == Brightness.dark
      ? const Color(0xff777777)
      : const Color(0xFFFFFFFF);
}

