import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image_platform_interface/cached_network_image_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../globals.dart';
import '../../logger.dart';
import '../../providers/file_provider.dart';

class AppImage extends ConsumerWidget {
  final String? assetName;
  final String? fileUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const AppImage({
    super.key,
    this.assetName,
    this.fileUrl,
    this.width,
    this.height,
    this.fit,
  }) : assert(assetName != null || fileUrl != null,
            'Either assetName or fileUrl must be provided, assetName: $assetName, fileUrl: $fileUrl');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return assetName != null ? buildAssetImage(assetName!) : buildFileImage(fileUrl!, ref);
  }

  // Builds an image from a flutter asset
  Widget buildAssetImage(String name) {
    return Image.asset(
      name,
      package: assetsPackage,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        logger.e('[AppAssetImage:buildAssetImage]: Error loading asset image: $name: $error',
            stackTrace: stackTrace);
        return Text(error.toString());
      },
    );
  }

  Widget buildFileImage(String id, WidgetRef ref) {
    logger.t('[AppFileImage.buildFileImage]: fileUrl: $id');
    final cacheManager = ref.watch(cacheManagerProvider);

    return CachedNetworkImage(
      imageUrl: id,
      width: width,
      height: height,
      fit: fit ?? BoxFit.cover,
      imageRenderMethodForWeb: ImageRenderMethodForWeb.HttpGet,
      cacheManager: cacheManager,
      progressIndicatorBuilder: (context, url, downloadProgress) {
        return Center(
          child: CircularProgressIndicator(value: downloadProgress.progress),
        );
      },
      errorWidget: (context, url, error) {
        return Text(error.toString());
      },
    );
  }
}
