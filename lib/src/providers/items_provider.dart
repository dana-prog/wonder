import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../client/items_client.dart';
import '../data/item.dart';
import '../logger.dart';
import 'client_provider.dart';

class ItemListNotifier extends StateNotifier<AsyncValue<List<Item>>> {
  final ItemsClient client;
  final String itemType;

  ItemListNotifier(Ref ref, this.itemType)
      : client = ref.read(clientProvider),
        super(const AsyncLoading()) {
    _load();
  }

  Future<void> _load() async {
    try {
      final items = await client.fetchItems<Item>(itemType: itemType);
      state = AsyncData(items);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> refresh() {
    logger.d('[FacilityListNotifier.refresh]');
    state = AsyncData([]);
    state = const AsyncLoading();
    return _load();
  }

  Future<Item> add(Map<String, dynamic> fields) async {
    logger.d('[FacilityListNotifier.create] $fields');
    final items = state.asData?.value ?? [];
    final newItem = await client.createItem(fields);
    state = AsyncData([newItem, ...items]);
    return newItem;
  }

  Future<Item> update(Item item) async {
    logger.d('[FacilityListNotifier.update] $item');
    final updatedItem = await client.updateItem(item);
    state = AsyncData(
      state.asData!.value.map((i) => i.id == updatedItem.id ? updatedItem : i).toList(),
    );
    return updatedItem;
  }

  Future<void> delete(Item item) async {
    logger.d('[FacilityListNotifier.delete] $item');
    await client.deleteItem(item);
    state = state.whenData((items) {
      return [
        for (final i in items)
          if (i.id != item.id) i
      ];
    });
  }
}

final itemListProvider =
    StateNotifierProvider.family<ItemListNotifier, AsyncValue<List<Item>>, String>(
  ((ref, type) => ItemListNotifier(ref, type)),
);

final itemProvider = FutureProvider.family<Item, (String, String)>((
  ref,
  itemKey,
) async {
  final wixClient = ref.watch(clientProvider);
  return await wixClient.fetchItem<Item>(
    itemType: itemKey.$1,
    id: itemKey.$2,
  );
});
