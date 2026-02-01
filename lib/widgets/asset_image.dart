import 'package:flutter/material.dart';

/// Loads and displays images from assets. Ported from Z-Editor-master AssetImage.kt
class AssetImageWidget extends StatelessWidget {
  const AssetImageWidget({
    super.key,
    required this.assetPath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.errorWidget,
  });

  /// Path relative to assets folder, e.g. 'images/stages/Stage_Modern.png'
  final String assetPath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetPath,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (_, __, ___) =>
          errorWidget ??
          Icon(
            Icons.image_not_supported,
            size: width ?? height ?? 48,
            color: Theme.of(context).colorScheme.outline,
          ),
    );
  }
}
