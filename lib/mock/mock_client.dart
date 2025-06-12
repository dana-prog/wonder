import 'package:wonder/src/client/client.dart';
import 'package:wonder/src/data/item.dart';

import '../src/logger.dart';
import 'mock_data.dart';

// TODO: remove
final defaultFieldValues = {
  'facility': {'type': 'facilityType_villa'}
};

final defaultMockItems = [
  ...MockData.facilities.sublist(0, 3),
  ...MockData.users,
  ...MockData.listValues,
];

var _nextItemId = 1;

class MockClient extends Client {
  late List<Item> items;

  MockClient({List<Item>? items}) {
    logger.d('[MockClient]');
    this.items = items ?? defaultMockItems;
    for (final item in this.items) {
      cache.set(item);
    }
  }

  @override
  Future<T> addItem<T extends Item>(Map<String, dynamic> fields) async {
    logger.d('[MockClient.createItem] fields: $fields');
    final id = fields['id'] ?? fields['title']?.toSnakeCase() ?? (_nextItemId++).toString();
    final dataCollectionId = metadata.getByName(fields['itemType']).dataCollectionId;

    T item = await super.addItem({
      ...defaultFieldValues[fields['itemType']] ?? {},
      ...fields,
      'id': id,
      'dataCollectionId': dataCollectionId,
    });
    items.add(item);
    return item;
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

    for (final item in items) {
      cache.set(item);
    }
  }
}
