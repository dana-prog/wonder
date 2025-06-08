import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/item.dart';
import '../../logger.dart';
import '../../providers/items_provider.dart';
import '../platform/error_view.dart';

const _itemType = 'facility';

typedef ItemBuilder = Widget Function(BuildContext context, Item item);

class ItemList extends ConsumerWidget {
  final String itemType;
  final ItemBuilder itemBuilder;

  const ItemList({
    required this.itemType,
    required this.itemBuilder,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemListNotifier = ref.read(itemListProvider(_itemType).notifier);
    final itemTypeListProvider = ref.watch(itemListProvider(_itemType));

    return itemTypeListProvider.when(
      data: (List<Item> items) {
        logger.d('[ItemList] build with ${items.length} items');
        return RefreshIndicator(
          onRefresh: itemListNotifier.refresh,
          child: ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, itemIndex) => itemBuilder(context, items[itemIndex]),
          ),
        );
      },
      loading: () => const LoadingItemList(),
      error: ErrorView.new,
    );
  }
}

class LoadingItemList extends StatelessWidget {
  const LoadingItemList({super.key});

  @override
  Widget build(BuildContext context) {
    logger.d('[LoadingItemList] build');
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
