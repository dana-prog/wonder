import 'package:flutter/material.dart';

import '../../../data/user_item.dart';
import 'initials_avatar.dart';

// TODO: move to assets folder
const _defaultUserPicture = 'assets/images/default_user.png';

class UserAvatar extends StatelessWidget {
  final UserItem? item;

  const UserAvatar({required this.item});

  @override
  Widget build(BuildContext context) {
    if (item == null) {
      return CircleAvatar(backgroundImage: AssetImage(_defaultUserPicture));
    }

    if (item!.avatar == null) {
      return InitialsAvatar(user: item!);
    }

    return CircleAvatar(backgroundImage: AssetImage('assets/images/${item!.avatar!}'));
  }
}
