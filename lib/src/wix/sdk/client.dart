import '../../data/item.dart';
import '../../logger.dart';

typedef ItemCallback = void Function(Item);

abstract class Client {
  final List<ItemCallback> _itemCreatedCallbacks = [];
  final List<ItemCallback> _itemUpdatedCallbacks = [];
  final List<ItemCallback> _itemDeletedCallbacks = [];

  void addItemCreatedCallback(ItemCallback callback) => _itemCreatedCallbacks.add(callback);

  void addItemUpdatedCallback(ItemCallback callback) => _itemUpdatedCallbacks.add(callback);

  void addItemDeletedCallback(ItemCallback callback) => _itemDeletedCallbacks.add(callback);

  Future<T> fetchItem<T extends Item>({required String itemType, required String id});

  Future<List<T>> fetchItems<T extends Item>({required String itemType});

  Future<T> updateItem<T extends Item>(T item);

  Future<T> deleteItem<T extends Item>({required String itemType, required String id});

  void notifyItemCreated(Item item) {
    for (var callback in _itemCreatedCallbacks) {
      callback(item);
    }
  }

  void notifyItemUpdated(Item item) {
    for (var callback in _itemUpdatedCallbacks) {
      callback(item);
    }
  }

  void notifyItemDeleted(Item item) {
    for (var callback in _itemDeletedCallbacks) {
      callback(item);
    }
  }

  // for debugging
  void printCachedItems() {
    logger.e('[Client.printCachedItems] Unimplemented');
  }
}
