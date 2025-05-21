import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wonder/src/data/list_value_item.dart';
import 'package:wonder/src/providers/wix_client_provider.dart';

import '../data/data_item.dart';
import '../wix/sdk/wix_client.dart';

final _allValuesProvider = FutureProvider<_ListsOfValues>((
  ref,
) async {
  if (_listsOfValues == null) {
    final wixClient = ref.watch(wixClientProvider);
    final values = await wixClient.fetchItems(
      dataCollectionId: DataItemType.listsOfValues.pluralName,
      itemConstructor: ListValueItem.fromDataCollection,
      sortBy: [
        ('type', SortOrder.ascending),
        ('order', SortOrder.ascending),
        ('title', SortOrder.ascending),
      ],
    );

    _listsOfValues = _ListsOfValues(values);
  }

  return _listsOfValues!;
});

final listOfValuesProvider = FutureProvider.family<List<ListValueItem>, ValueItemType>((
  ref,
  listType,
) async {
  final listsOfValues = await ref.watch(_allValuesProvider.future);
  return listsOfValues.getList(listType);
});

final listValueProvider = FutureProvider.family<ListValueItem, String>((
  ref,
  id,
) async {
  final listsOfValues = await ref.watch(_allValuesProvider.future);
  return listsOfValues.getValueById(id);
});

class _ListsOfValues {
  late Map<String, ListValueItem> _itemsById;
  late Map<ValueItemType, Map<String, ListValueItem>> _listsByType;

  _ListsOfValues(List<ListValueItem> valueItems) {
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

  List<ListValueItem> getList(ValueItemType type) {
    final list = _listsByType[type];
    if (list == null) {
      throw Exception('No items found for type $type');
    }
    return list.values.toList();
  }
}

_ListsOfValues? _listsOfValues;
