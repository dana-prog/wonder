import 'package:wonder/src/client/client.dart';
import 'package:wonder/src/data/item.dart';

import '../src/logger.dart';
import 'mock_data.dart';

final defaultMockItems = [
  ...MockData.facilities,
  ...MockData.users,
  ...MockData.listValues,
];

class MockClient extends Client {
  late List<Item> initialItems;

  MockClient({List<Item>? items}) {
    initialItems = items ?? defaultMockItems;
    for (final item in initialItems) {
      cache.set(item);
    }
  }

  @override
  Future<T> fetchItem<T extends Item>({
    required String itemType,
    required String id,
  }) async {
    logger.t('[MockClient.fetchItem] $itemType/$id');
    return cache[id];
  }

  @override
  Future<List<T>> fetchItems<T extends Item>({required String itemType}) async {
    logger.t('[MockClient.fetchItems] $itemType');
    return cache.getByType<T>(itemType);
  }

  @override
  void resetCache() {
    cache.clear();

    for (final item in initialItems) {
      cache.set(item);
    }
  }
}
