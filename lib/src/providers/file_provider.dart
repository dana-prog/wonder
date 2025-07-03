import 'package:flutter_cache_manager/flutter_cache_manager.dart' as fcm;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../storage/file_storage.dart';
import '../storage/file_storage_plugin.dart';

final fileStoragePluginProvider = Provider<FileStoragePlugin>(
    (ref) => throw Exception('fileStoragePluginProvider state was not set'));

final fileStorageProvider = Provider<FileStorage>((ref) {
  final fileStoragePlugin = ref.watch(fileStoragePluginProvider);
  return FileStorage(fileStoragePlugin);
});

final cacheManagerProvider = Provider<fcm.CacheManager>((ref) {
  final fileStorage = ref.watch(fileStorageProvider);
  return fileStorage.cacheManager;
});

final fileBytesProvider = FutureProvider.family<List<int>, String>((ref, id) async {
  final fileStorage = ref.watch(fileStorageProvider);
  return await fileStorage.get(id);
});
