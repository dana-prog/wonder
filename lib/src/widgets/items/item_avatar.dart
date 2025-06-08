import 'package:flutter/material.dart';

import '../../data/item.dart';
import '../../globals.dart';

class ItemAvatar extends StatelessWidget {
  final Item item;

  const ItemAvatar({required this.item});

  @override
  Widget build(BuildContext context) {
    if (item.avatar == null || item.avatar!.isEmpty) {
      return CircleAvatar(
        backgroundImage: AssetImage('$imagesPath/default_${item.itemType}_picture.png'),
      );
    }

    return CircleAvatar(backgroundImage: AssetImage(item.avatar!));
  }
}
