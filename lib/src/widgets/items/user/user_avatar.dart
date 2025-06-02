import 'package:flutter/material.dart';

import '../../../data/item_helpers.dart';
import '../../../data/user_item.dart';
import 'initials_avatar.dart';

const _defaultUserPicture = '$mediaPublicUrlPrefix/1246fe_7609a78c62784e4788f3fb2c6a65fb95~mv2.png';

class UserAvatar extends StatelessWidget {
  final UserItem? item;

  const UserAvatar({required this.item});

  @override
  Widget build(BuildContext context) {
    if (item == null) {
      return CircleAvatar(backgroundImage: NetworkImage(_defaultUserPicture));
    }

    if (item!.avatar == null) {
      return InitialsAvatar(user: item!);
    }

    return CircleAvatar(backgroundImage: AssetImage(item!.avatar!));
  }
}
