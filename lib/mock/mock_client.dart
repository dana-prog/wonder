import 'package:wonder/mock/mock_file_storage_plugin.dart';

import '../src/client/client.dart';
import 'mock_items_client.dart';

class MockClient extends Client {
  MockClient()
      : super(
          itemsClient: MockItemsClient(),
          fileStoragePlugin: MockFileStoragePlugin(),
        );
}
