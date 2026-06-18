import 'package:flutter/material.dart';

abstract final class ResponsiveLayout {
  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).shortestSide >= 600;

  static double getResponsiveFontSize(BuildContext context, double size) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= 600) return size * 1.15;
    if (width < 340) return size * 0.92;
    return size;
  }

  static int getGridCrossAxisCount(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= 900) return 4;
    if (width >= 600) return 3;
    return 2;
  }
}
