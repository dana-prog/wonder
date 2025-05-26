import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wonder/src/data/list_value_item.dart';

final listsValuesProvider =
    Provider<ListsValuesCache>((ref) => throw Exception('listsValuesProvider state was not set'));

final listValuesProvider = Provider.family<List<ListValueItem>, String>((
  ref,
  listType,
) {
  final listsOfValues = ref.watch(listsValuesProvider);
  return listsOfValues.getList(listType);
});

final listValueProvider = Provider.family<ListValueItem, String>((
  ref,
  id,
) {
  final listsOfValues = ref.watch(listsValuesProvider);
  return listsOfValues.getValueById(id);
});

class ListsValuesCache {
  late Map<String, ListValueItem> _itemsById;
  late Map<String, Map<String, ListValueItem>> _listsByType;

  ListsValuesCache(List<ListValueItem> valueItems) {
    _itemsById = {};
    _listsByType = {};

    for (var item in valueItems) {
      // TODO: remove !
      _listsByType[item.valueItemType] ??= {};

      _itemsById[item.id] = item;
      _listsByType[item.valueItemType]![item.name] = item;
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

  bool get empty => _itemsById.isEmpty;
}
