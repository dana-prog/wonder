import 'package:wonder/src/client/items_client.dart';
import 'package:wonder/src/client/wix/wix_utils.dart';
import 'package:wonder/src/data/item.dart';

import '../src/logger.dart';
import 'mock_authentication.dart';
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

class MockClient extends ItemsClient {
  late List<Item> initialItems;

  MockClient({List<Item>? items}) : super(authentication: MockAuthentication()) {
    logger.d('[MockClient]');
    initialItems = items ?? defaultMockItems;
    for (final item in initialItems) {
      notifyItemFetched(item);
    }
  }

  @override
  Future<T> createItem<T extends Item>(Map<String, dynamic> fields) async {
    logger.d('[MockClient.createItem] fields: $fields');
    final id = fields['id'] ?? fields['title']?.toSnakeCase() ?? (_nextItemId++).toString();
    final dataCollectionId = metadata.getByName(fields['itemType']).dataCollectionId;

    T item = dataItemToItem({
      ...defaultFieldValues[fields['itemType']] ?? {},
      ...fields,
      'id': id,
      'dataCollectionId': dataCollectionId,
    });
    notifyItemCreated(item);
    return getCachedItem(item.itemType, item.id!)!;
  }

  @override
  Future<T> fetchItem<T extends Item>({
    required String itemType,
    required String id,
  }) async {
    logger.t('[MockClient.fetchItem] $itemType/$id');
    return getCachedItem<T>(itemType, id)!;
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

  @override
  Future<T> deleteItem<T extends Item>(T item) async {
    notifyItemDeleted(item);
    return item;
  }

  @override
  Future<T> updateItem<T extends Item>(T newItem) async {
    notifyItemUpdated(newItem);
    return getCachedItem(newItem.itemType, newItem.id!)!;
  }
}
