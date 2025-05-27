import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/item.dart';
import 'client_provider.dart';

class EventNotifier extends StateNotifier<(String, Item)?> {
  EventNotifier(this.ref) : super(null) {
    final client = ref.read(clientProvider);

    client.addItemCreatedCallback((item) => state = ('create', item));
    client.addItemUpdatedCallback((item) => state = ('update', item));
    client.addItemDeletedCallback((item) => state = ('delete', item));
  }

  final Ref ref;

  void clear() => state = null;
}

final eventProvider = StateNotifierProvider<EventNotifier, (String, Item)?>(
  (ref) => EventNotifier(ref),
);
