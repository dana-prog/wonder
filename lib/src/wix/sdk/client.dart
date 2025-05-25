import '../../data/item.dart';
import '../../logger.dart';

abstract class Client {
  Future<T> fetchItem<T extends Item>({required String itemType, required String id});

  Future<List<T>> fetchItems<T extends Item>({required String itemType});

  Future<T> updateItem<T extends Item>(T item);

  Future<void> deleteItem<T extends Item>({required String itemType, required String id});

  // for debugging
  void printCachedItems() {
    logger.e('[Client.printCachedItems] Unimplemented');
  }
}
