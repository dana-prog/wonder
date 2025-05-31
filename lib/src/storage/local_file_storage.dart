import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../logger.dart';
import 'file_storage.dart';

class LocalFileStorage extends FileStorage {
  @override
  Future<String> saveFile(Stream<Uint8List> stream, String name) async {
    logger.t('[LocalFileStorage:saveFile]: name: $name');
    final id = '${Uuid().v4()}_$name';
    final file = await getFile(id);
    // 💡 Ensure parent directories exist
    await file.parent.create(recursive: true);
    final sink = file.openWrite(mode: FileMode.writeOnly);
    await sink.addStream(stream);
    // await sink.flush();
    await sink.close();
    return id;
  }

  @override
  Future<File> getFile(String id) async {
    final dir = await getApplicationDocumentsDirectory();
    final path = getFilePath(id);
    return File('${dir.path}/$path');
  }

  @override
  Future<Uint8List> loadFile(String id) async {
    logger.t('[LocalFileStorage:loadFile]: id: $id');
    final file = await getFile(id);
    if (!await file.exists()) {
      throw FileSystemException('File not found', file.path);
    }
    logger.d('[LocalFileStorage:loadFile]: loading file with id: $id, from path: ${file.path}');
    return await file.readAsBytes();
  }

  @override
  Future<void> deleteFile(String id) async {
    logger.t('[LocalFileStorage:deleteFile]: id: $id');
    final file = await getFile(id);
    final exists = await file.exists();
    if (!exists) {
      logger.w(
          '[LocalFileStorage:deleteFile]: File with id: $id does not exist at path: ${file.path}');
      return;
    }
    await file.delete();
  }

  @override
  String getFilePath(String id) => id;
}
