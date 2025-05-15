import 'package:flutter/material.dart';

class DefaultItemCard extends StatelessWidget {
  final dynamic item;

  DefaultItemCard(this.item) : super(key: ValueKey(item['id']));

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        // leading: AppIcon.item(
        //   item.id,
        //   height: 30,
        //   width: 30,
        // ),
        title: getTitle(item),
        // subtitle: Text(item.definition),
        // onTap: () => navigateToItem(
        //   item.id,
        //   context,
        // ),
      ),
    );
  }

  Widget getTitle(dynamic item) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(item['id']),
      ],
    );
  }
}
