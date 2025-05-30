import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'local_file_storage.dart';

abstract class FileStorage {
  Future<String> saveFile(Stream<Uint8List> stream, String name);
  Future<Uint8List> loadFile(String id);
  Future<void> deleteFile(String id);
  Future<File> getFile(String id);
  String getFilePath(String id);
}

final fileStorageProvider = Provider<FileStorage>(
  (ref) => LocalFileStorage(),
);
