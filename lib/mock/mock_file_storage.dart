import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wonder/mock/mock_files.dart';

import '../src/data/file_item.dart';
import '../src/logger.dart';
import '../src/storage/file_storage_plugin.dart';

class MockFileStorage extends FileStoragePlugin {
  @override
  Future<String> add({
    required Uint8List fileBytes,
    required String name,
    required String mimeType,
    required FileContext fileContext,
  }) async {
    logger.t('[MockFileStorage:saveFile]: name: $name');
    return '$name|$mimeType';
  }

  @override
  Future<FileItem> getInfo(String id) async {
    if (mockImages[id] == null) {
      throw FileSystemException('File not found', id);
    }

    final idParts = id.split('|');
    return FileItem({
      'id': id,
      'fileName': idParts[0],
      'mimeType': idParts[1],
    });
  }

  @override
  Future<FileServiceResponse> get(String id, {Map<String, String>? headers}) async {
    logger.t('[MockFileStorage.getFile]: id: $id');
    final url = mockImages[id];
    if (url == null) {
      logger.e('[MockFileStorage.getFile]: File not found for id: $id');
      throw FileSystemException('File not found', id);
    }

    return await HttpFileService().get(url, headers: headers);
  }
}
