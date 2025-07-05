import 'dart:typed_data';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wonder/mock/mock_data.dart';

import '../src/data/file_item.dart';
import '../src/logger.dart';
import '../src/storage/file_storage_plugin.dart';

class MockFileStoragePlugin extends FileStoragePlugin {
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
    return MockData.allFiles.firstWhere((file) => file.id == id);
  }

  @override
  Future<FileServiceResponse> get(String id, {Map<String, String>? headers}) async {
    logger.t('[MockFileStorage.getFile]: id: $id');
    // make sure the id exists in mock data
    MockData.allFiles.firstWhere((file) => file.id == id);

    return await HttpFileService().get(id, headers: headers);
  }

  @override
  Future<List<FileItem>> listFiles({
    String? parentFolderId,
    bool includeSubfolders = false,
  }) async {
    return MockData.allFiles;
  }
}
