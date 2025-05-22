import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/item.dart';
import '../../logger.dart';
import '../../utils/multitap/multitap.dart';
import '../cards/default_item_card.dart';

class ItemList<T extends Item> extends StatelessWidget {
  final List<T> items;
  final Widget Function(T) itemBuilder;

  const ItemList(
    this.items, {
    this.itemBuilder = DefaultItemCard.new,
  });

  @override
  Widget build(BuildContext context) {
    logger.t(
      '[ItemList.build] items.length = ${items.length}',
    );

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => MultiTapGestureWrapper(
        onShortTap: (pointer) {
          logger.t('[ItemList.onShortTap] pointer: $pointer');
          final route = '/${items[index].itemType.name}/${items[index].id}';
          logger.d('[ListView.builder] navigate to $route');
          context.push(route);
        },
        onLongTapDown: (int pointer, TapDownDetails details) {
          // Handle long tap down
          logger.t('[ItemList.onLongTapDown] pointer: $pointer, details: $details');
        },
        child: itemBuilder(items[index]),
      ),
    );
  }
}
