import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import 'file_storage.dart';

const _storagePath = 'assets/storage';

class LocalFileStorage extends FileStorage {
  @override
  Future<String> saveFile(Stream<Uint8List> stream, String name) async {
    final id = '${Uuid().v4()}_$name';
    final file = await getFile(id);
    final sink = file.openWrite(mode: FileMode.writeOnly);
    await sink.addStream(stream);
    sink.flush();
    sink.close();
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
    final file = await getFile(id);
    return await file.readAsBytes();
  }

  @override
  Future<void> deleteFile(String id) async {
    final file = await getFile(id);
    if (await file.exists()) {
      await file.delete();
    }
  }

  @override
  String getFilePath(String id) => '$_storagePath/$id';
}
