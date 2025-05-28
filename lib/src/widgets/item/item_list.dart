import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/item.dart';
import '../../logger.dart';
import '../../providers/items_provider.dart';
import '../async/async_value_widget.dart';

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

    return AsyncValueWidget<List<Item>>(
      asyncValue: ref.watch(itemListProvider(_itemType)),
      dataBuilder: (
        List<Item> items,
        BuildContext context,
      ) {
        logger.d('[ItemList] build with ${items.length} items');
        return RefreshIndicator(
          onRefresh: itemListNotifier.refresh,
          child: ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: items.length,
            // itemBuilder: (context, itemIndex) => Text(items[itemIndex].toString()),
            itemBuilder: (context, itemIndex) => itemBuilder(context, items[itemIndex]),
          ),
        );
      },
    );
  }
}
