import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart' as fcm;

import '../data/file_item.dart';

class FileContext {
  final String itemType;
  final String itemId;
  final String fieldName;

  const FileContext({
    required this.itemType,
    required this.itemId,
    required this.fieldName,
  });
}

// we wanted to define the FileStoragePlugin without a dependency on fcm
// the problem is that the fcm needs additional info besides the file stream
// so either we return fcm.FileServiceResponse or some other proprietary class which will be de facto a fcm.FileServiceResponse
abstract class FileStoragePlugin extends fcm.FileService {
  Future<String> add({
    required Uint8List fileBytes,
    required String name,
    required String mimeType,
    required FileContext fileContext,
  });

  Future<FileItem> getInfo(String id);

  @override
  Future<fcm.FileServiceResponse> get(String id, {Map<String, String>? headers});

  Future<List<FileItem>> listFiles({String? parentFolderId, bool includeSubfolders = false});
}
