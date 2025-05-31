import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../storage/file_storage.dart';
import '../storage/local_file_storage.dart';

final fileStorageProvider = Provider<FileStorage>(
  (ref) => LocalFileStorage(),
);

final fileProvider = FutureProvider.family<File, String>((ref, id) async {
  final fileStorage = ref.watch(fileStorageProvider);
  return await fileStorage.getFile(id);
});
