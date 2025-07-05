import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/item.dart';
import 'items_provider.dart';

class EventNotifier extends StateNotifier<(String, Item)?> {
  EventNotifier(this.ref) : super(null) {
    final itemsClient = ref.read(itemsClientProvider);

    itemsClient.addItemCreatedCallback((item) => state = ('create', item));
    itemsClient.addItemUpdatedCallback((item) => state = ('update', item));
    itemsClient.addItemDeletedCallback((item) => state = ('delete', item));
  }

  final Ref ref;

  void clear() => state = null;
}

final eventProvider = StateNotifierProvider<EventNotifier, (String, Item)?>(
  (ref) => EventNotifier(ref),
);
