import 'package:flutter/material.dart';

import '../../logger.dart';
import '../cards/default_item_card.dart';

class ItemListView<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(T) itemBuilder;

  const ItemListView(
    this.items, {
    this.itemBuilder = DefaultItemCard.new,
  });

  @override
  Widget build(BuildContext context) {
    logger.t(
      '[ListView.build] items.length = ${items.length}',
    );

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => itemBuilder(items[index]),
    );
  }
}
