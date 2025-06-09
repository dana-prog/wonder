import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../globals.dart';
import '../../logger.dart';
import '../../providers/file_provider.dart';

class AppAssetImage extends AssetImage {
  const AppAssetImage(super.name) : super(package: assetsPackage);
}

class AppImage extends StatelessWidget {
  final String? assetName;
  final String? filePath;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const AppImage({
    super.key,
    this.assetName,
    this.filePath,
    this.width,
    this.height,
    this.fit,
  }) : assert(
            assetName != null || filePath != null, 'Either assetName or filePath must be provided');

  @override
  Widget build(BuildContext context) {
    return assetName != null ? buildAssetImage(assetName!) : buildFileImage(filePath!);
  }

  Widget buildAssetImage(String name) {
    return Image.asset(
      name,
      package: assetsPackage,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        logger.e('[AppAssetImage:build]: Error loading asset image: $name: $error',
            stackTrace: stackTrace);
        return Text(error.toString());
      },
    );
  }

  Widget buildFileImage(String path) {
    logger.t('[AppFileImage:build]: path: $path');
    return Consumer(
      builder: (context, ref, child) {
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
      },
    );
  }
}
