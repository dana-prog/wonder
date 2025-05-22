import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wonder/src/data/image_fields.dart';

import '../../logger.dart';

class AppImage extends StatelessWidget {
  final ImageFields imageFields;
  final double? width;
  final double? height;

  const AppImage(
    this.imageFields, {
    this.width,
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    logger.t('[AppImage:build]: url: ${imageFields.url}');
    return Image.network(
      imageFields.url,
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
