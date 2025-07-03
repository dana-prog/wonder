import 'dart:typed_data';

import 'package:flutter_cache_manager/flutter_cache_manager.dart' as fcm;
import 'package:wonder/src/client/wix/wix_api_service.dart';
import 'package:wonder/src/storage/file_storage_plugin.dart';

import '../../data/file_item.dart';
import '../../logger.dart';
import '../authentication.dart';

class WixFileStorage extends FileStoragePlugin {
  final Authentication authentication;

  WixFileStorage({required this.authentication});

  @override
  Future<String> add({
    required Uint8List fileBytes,
    required String name,
    required String mimeType,
    required FileContext fileContext,
  }) async {
    await authentication.login();
    logger.d(
        '[WixFileStorage.saveFile] Saving file: $name, MIME type: $mimeType, fileContext: $fileContext');
    try {
      final uploadUrl = await GenerateUploadUrlEndpoint(
        accessToken: authentication.accessToken,
        fileName: name,
        mimeType: mimeType,
        context: fileContext,
      ).call();

      logger.d('[WixFileStorage.saveFile] Upload URL: $uploadUrl');

      final fileProps = await UploadFileEndpoint(
        fileBytes: fileBytes,
        uploadUrl: uploadUrl,
        mimeType: mimeType,
        fileName: name,
      ).call();

      logger.d('[WixFileStorage.saveFile] File saved with ID: ${fileProps['id']}');
      return fileProps['id'];
    } catch (e, stackTrace) {
      logger.e('[WixFileStorage.saveFile] Error saving file: $e\n$stackTrace');
      return '';
    }
  }

  @override
  Future<FileItem> getInfo(String id) async {
    await authentication.login();

    FileItem? file;
    try {
      file = await FileInfoEndpoint(accessToken: authentication.accessToken, fileUrl: id).call();
    } catch (e) {
      logger.e('[WixFileStorage.getFile] Error getting file: $e');
      rethrow;
    }

    if (file == null) {
      throw Exception('[WixFileStorage. getFileItem] File not found for ID: $id');
    }

    return file;
  }

  @override
  Future<fcm.FileServiceResponse> get(String id, {Map<String, String>? headers}) async {
    logger.t('[WixFileStorage.get]: id: $id');
    await authentication.login();
    final downloadUrl = await GenerateDownloadUrlEndpoint(
      accessToken: authentication.accessToken,
      fileUrl: id,
    ).call();

    return fcm.HttpFileService().get(downloadUrl, headers: headers);
  }
}
