import 'package:flutter/material.dart';
import 'package:wonder/src/widgets/items/user/initials_avatar.dart';

import '../../../data/user_item.dart';

// TODO: move to assets folder
// const _defaultUserPicture = 'default_user.png';

class UserAvatar extends StatelessWidget {
  final UserItem? item;

  const UserAvatar({required this.item});

  @override
  Widget build(BuildContext context) {
    return InitialsAvatar(user: item!);
    // TODO: uncomment and test
    // if (item != null && item!.avatar == null) {
    //   // user with no pic - show initials
    //   return InitialsAvatar(user: item!);
    // }
    //
    // return AspectRatio(
    //   aspectRatio: 1,
    //   child: ClipOval(
    //     child: AppImage(
    //       assetName: '$imagesPath/${item?.avatar ?? _defaultUserPicture}',
    //       fit: BoxFit.cover,
    //     ),
    //   ),
    // );
  }
}
