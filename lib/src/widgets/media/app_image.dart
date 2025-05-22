import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../logger.dart';

class AppImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;

  const AppImage(
    this.url, {
    this.width,
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    logger.d('[AppImage:build]: url: $url');
    return Image.network(
      url,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Text(error.toString());
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }

        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          enabled: true,
          child: child,
        );
      },
    );
  }
}
