import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../logger.dart';
import '../../providers/file_provider.dart';

class AppFileImage extends ConsumerWidget {
  final String path;
  final double? width;
  final double? height;

  const AppFileImage({
    required this.path,
    this.width,
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    logger.t('[AppFileImage:build]: path: $path');
    final asyncFile = ref.watch(fileProvider(path));

    return asyncFile.when(
        data: (file) => Image.file(
              file,
              width: width,
              height: height,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                logger.e('[AppFileImage:build]: Error loading file: ${file.path}: $error',
                    stackTrace: stackTrace);
                return Text(error.toString());
              },
            ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) {
          logger.e(
            '[AppFileImage:build]: Error loading file: $path: $error',
            stackTrace: stackTrace,
          );
          return Text(error.toString());
        });

    // return AsyncValueWidget(
    //   asyncValue: asyncFile,
    //   loadingBuilder: (context) => const Center(child: CircularProgressIndicator()),
    //   dataBuilder: (file, _) => Image.file(
    //     file,
    //     width: width,
    //     height: height,
    //     fit: BoxFit.cover,
    //     errorBuilder: (context, error, stackTrace) {
    //       logger.e('[AppFileImage:build]: Error loading file: ${file.path}: $error',
    //           stackTrace: stackTrace);
    //       return Text(error.toString());
    //     },
    //   ),
    // );
  }
}

class AppAssetImage extends StatelessWidget {
  final String assetPath;
  final double? width;
  final double? height;

  const AppAssetImage({
    required this.assetPath,
    this.width,
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    logger.t('[AppAssetImage:build]: assetPath: $assetPath');
    return Image.asset(
      assetPath,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        logger.e('[AppAssetImage:build]: Error loading asset image: $assetPath: $error',
            stackTrace: stackTrace);
        return Text(error.toString());
      },
    );
  }
}
