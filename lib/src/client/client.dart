import 'package:flutter/cupertino.dart';

import '../data/item.dart';
import '../data/metadata.dart';
import '../logger.dart';
import 'authentication.dart';

typedef ItemCallback = void Function(Item);

abstract class Client {
  final Authentication authentication;
  Client({required this.authentication});

  final List<ItemCallback> _itemCreatedCallbacks = [];
  final List<ItemCallback> _itemUpdatedCallbacks = [];
  final List<ItemCallback> _itemDeletedCallbacks = [];

  @protected
  final cache = _Cache();

  @protected
  final metadata = Metadata();

  void addItemCreatedCallback(ItemCallback callback) => _itemCreatedCallbacks.add(callback);

  void addItemUpdatedCallback(ItemCallback callback) => _itemUpdatedCallbacks.add(callback);

  void addItemDeletedCallback(ItemCallback callback) => _itemDeletedCallbacks.add(callback);

  void notifyItemCreated(Item item) {
    cache.set(item);
    for (var callback in _itemCreatedCallbacks) {
      callback(item);
    }
  }

  void notifyItemUpdated(Item item) {
    Item cachedItem = cache.exists(item.id!) ? cache.update(item) : cache.set(item);

    for (var callback in _itemUpdatedCallbacks) {
      callback(cachedItem);
    }
  }

  void notifyItemDeleted(Item item) {
    cache.remove(item);

    for (var callback in _itemDeletedCallbacks) {
      callback(item);
    }
  }

  void notifyItemFetched(Item item) => cache.set(item);

  Future<T> fetchItem<T extends Item>({required String itemType, required String id});

  Future<List<T>> fetchItems<T extends Item>({required String itemType});

  Future<T> createItem<T extends Item>(Map<String, dynamic> fields);

  Future<T> updateItem<T extends Item>(T newItem);

  Future<T> deleteItem<T extends Item>(T item);

  T? getCachedItem<T extends Item>(String itemType, String id) =>
      cache.exists(id) ? cache[id] as T : null;

  // for debugging
  void printCachedItems() => logger.e('[Client.printCachedItems] Unimplemented');

  void printMyMember() => logger.e('[Client.printMyMember] Unimplemented');

  Future<void> logout() async => logger.e('[Client.logout] Unimplemented');

  // TODO: remove?
  void resetCache() async => cache.clear();
}

// TODO: remove cache (should not be in the base class)
class _Cache {
  static final _Cache _instance = _Cache._internal();

  factory _Cache() {
    return _instance;
  }

  _Cache._internal();

  final Map<String, Item> itemsById = {};

  bool exists(String id) {
    return itemsById.containsKey(id);
  }

  dynamic operator [](String id) {
    return itemsById.containsKey(id)
        ? itemsById[id]
        : throw Exception(
            "Item with id $id not found in cache",
          );
  }

  T getByName<T extends Item>(String itemType, String name) {
    return itemsById.values.firstWhere(
      (item) => item.itemType == itemType && name == name,
      orElse: () => throw Exception('Item with name $name not found in cache for type $itemType'),
    ) as T;
  }

  List<T> getByType<T extends Item>(String itemType) {
    List<T> result = [];
    for (final item in itemsById.values) {
      if (item.itemType == itemType) {
        result.add(item as T);
      }
    }

    return result;
  }

  T set<T extends Item>(T item) {
    assert(
        item.id != null, 'Item id must not be null (cannot add new items without id to the cache)');
    itemsById[item.id!] = item;
    return item;
  }

  T update<T extends Item>(T updatedItem) {
    assert(updatedItem.id != null, 'Item id must not be null for update');

    if (!exists(updatedItem.id!)) {
      throw Exception('[_Cache.updateItem] Item with id ${updatedItem.id} not found in cache');
    }

    final oldItem = this[updatedItem.id!] as T;

    for (MapEntry<String, dynamic> field in updatedItem.fields.entries) {
      oldItem[field.key] = field.value;
    }

    return oldItem;
  }

  T remove<T extends Item>(T deletedItem) {
    assert(deletedItem.id != null, 'Item id must not be null for delete');
    if (!exists(deletedItem.id!)) {
      throw Exception('[_Cache.deleteItem] Item with id ${deletedItem.id} not found in cache');
    }

    return itemsById.remove(deletedItem.id) as T;
  }

  void clear() => itemsById.clear();
}
