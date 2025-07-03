import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart' as fcm;
import 'package:mime/mime.dart';

import '../data/file_item.dart';
import '../logger.dart';
import 'file_storage_plugin.dart';

class FileStorage {
  final FileStoragePlugin fileStoragePlugin;
  final fcm.CacheManager cacheManager;

  FileStorage(this.fileStoragePlugin) : cacheManager = _CacheManager(fileStoragePlugin);

  Future<String?> add({
    required Uint8List fileBytes,
    required String name,
    required String mimeType,
    required FileContext fileContext,
  }) async {
    final fileId = await fileStoragePlugin.add(
      fileBytes: fileBytes,
      name: name,
      mimeType: mimeType,
      fileContext: fileContext,
    );

    if (fileId.isEmpty) {
      logger.e('Failed to add file: $name, MIME type: $mimeType to file storage');
      return null;
    }

    // TODO: check if we really need to wait here
    await cacheManager.putFile(
      fileId, // url doesn't have to be a valid URL, just a unique identifier - in our case, the file ID
      fileBytes,
      fileExtension: extensionFromMime(mimeType) ?? 'file',
    );

    return fileId;
  }

  Future<List<int>> get(String id, {Map<String, String>? headers}) async {
    logger.t('[FileService.get]: id: $id');
    final file = await cacheManager.getSingleFile(id, headers: headers);
    return await file.readAsBytes();
  }

  // override to provide a custom download URL
  Future<String> getDownloadUrl(String id) async => id;

  Future<FileItem> getInfo(String url) => fileStoragePlugin.getInfo(url);
}

/// _CacheManager is a wrapper around CacheManager which passes a custom Config (mainly FileService implementation)
class _CacheManager extends fcm.CacheManager with fcm.ImageCacheManager {
  static const key = 'appCachedImageData';
  static const maxNrOfCacheObjects = 200;
  static const stalePeriod = Duration(days: 30);

  _CacheManager(fcm.FileService fileFetcher)
      : super(
          fcm.Config(
            key,
            stalePeriod: stalePeriod,
            maxNrOfCacheObjects: maxNrOfCacheObjects,
            fileService: fileFetcher,
          ),
        );
}
