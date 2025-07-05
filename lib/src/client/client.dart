import 'package:wonder/src/client/items_client.dart';
import 'package:wonder/src/storage/file_storage_plugin.dart';

class Client {
  final ItemsClient itemsClient;
  final FileStoragePlugin fileStoragePlugin;

  Client({
    required this.itemsClient,
    required this.fileStoragePlugin,
  });
}
