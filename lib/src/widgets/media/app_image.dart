import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../logger.dart';
import '../../storage/file_storage.dart';

class AppImage extends ConsumerWidget {
  final String id;
  final double? width;
  final double? height;

  const AppImage({
    required this.id,
    this.width,
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    logger.t('[AppImage:build]: id: $id');
    final fileStorage = ref.watch(fileStorageProvider);
    return Image.asset(
      fileStorage.getFilePath(id),
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        logger.e(
          '[AppImage:build]: Error loading image: $id: $error',
          stackTrace: stackTrace,
        );
        return Text(error.toString());
      },
      // loadingBuilder: (context, child, loadingProgress) {
      //   if (loadingProgress == null) {
      //     return child;
      //   }
      //
      //   return Shimmer.fromColors(
      //     baseColor: Colors.grey.shade300,
      //     highlightColor: Colors.grey.shade100,
      //     enabled: true,
      //     child: Container(
      //       width: width,
      //       height: height,
      //       color: Colors.grey.shade300,
      //     ),
      //   );
      // },
    );
  }
}
