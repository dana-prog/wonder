import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wonder/src/data/list_value_item.dart';

// TODO: create a cache for all types of items (unify with the client cache)
final listsValuesProvider = Provider<ListsValuesCache>(
  (ref) => throw Exception('listsValuesProvider state was not set'),
);

final listValuesProvider = Provider.family<List<ListValueItem>, String>((ref, listType) {
  final listsOfValues = ref.watch(listsValuesProvider);
  return listsOfValues.getList(listType);
});

final listValueProvider = Provider.family<ListValueItem, String>((ref, id) {
  final listsValues = ref.watch(listsValuesProvider);
  return listsValues.getValueById(id);
});

class ListsValuesCache {
  late Map<String, ListValueItem> _itemsById;
  late Map<String, Map<String, ListValueItem>> _listsByType;

  ListsValuesCache(List<ListValueItem> valueItems) {
    _itemsById = {};
    _listsByType = {};

    for (var item in valueItems) {
      assert(
        item.id.isNotEmpty,
        'ListValueItem id cannot be empty (cannot add new items without id to the cache)',
      );
      _listsByType[item.type] ??= {};

      _itemsById[item.id] = item;
      _listsByType[item.type]![item.name] = item;
    }
  }

  ListValueItem getValueById(String id) {
    final item = _itemsById[id];
    if (item == null) {
      throw Exception('Item with id $id not found');
    }

    return item;
  }

  List<ListValueItem> getList(String type) {
    final list = _listsByType[type];
    if (list == null) {
      throw Exception('No items found for type $type');
    }
    return list.values.toList();
  }

  ListValueItem getValueByName(String type, String name) {
    final list = _listsByType[type];
    if (list == null) {
      throw Exception('No items found for type $type');
    }
    final item = list[name];
    if (item == null) {
      throw Exception('Item with name $name not found in type $type');
    }
    return item;
  }

  bool get empty => _itemsById.isEmpty;
}
