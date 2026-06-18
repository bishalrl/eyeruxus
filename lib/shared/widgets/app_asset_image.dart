import 'package:flutter/material.dart';

/// Loads a bundled asset from [Assets/] with consistent sizing defaults.
class AppAssetImage extends StatelessWidget {
  const AppAssetImage({
    super.key,
    required this.asset,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.color,
    this.semanticLabel,
  });

  final String asset;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset,
      width: width,
      height: height,
      fit: fit,
      color: color,
      semanticLabel: semanticLabel,
      errorBuilder: (_, __, ___) => Icon(
        Icons.broken_image_outlined,
        size: width ?? height ?? 24,
        color: Colors.grey,
      ),
    );
  }
}
