import 'package:flutter/material.dart';

abstract final class LiveRoomTheme {
  static const hostGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1F0A0A), Color(0xFF120606), Color(0xFF050505)],
  );

  static const viewerGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF0D0D12), Color(0xFF050508)],
  );

  static const accent = Color(0xFFAF1D18);
  static const gold = Color(0xFFFFD54F);

  static BoxDecoration glass({
    Color color = Colors.white,
    double opacity = 0.08,
    double radius = 16,
    Border? border,
  }) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      color: color.withValues(alpha: opacity),
      border: border ??
          Border.all(color: Colors.white.withValues(alpha: 0.12)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.25),
          blurRadius: 18,
          offset: const Offset(0, 8),
        ),
      ],
    );
  }

  static String formatDuration(int seconds) {
    final h = seconds ~/ 3600;
    final m = (seconds % 3600) ~/ 60;
    final s = seconds % 60;
    if (h > 0) {
      return '${h.toString().padLeft(2, '0')}:'
          '${m.toString().padLeft(2, '0')}:'
          '${s.toString().padLeft(2, '0')}';
    }
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  static String formatCount(int n) {
    if (n >= 1000000) return '${(n / 1000000).toStringAsFixed(1)}M';
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}K';
    return '$n';
  }
}
