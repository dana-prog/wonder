import 'package:flutter/material.dart';
import 'package:wonder/src/widgets/items/user/initials_avatar.dart';
import 'package:wonder/src/widgets/media/app_image.dart';

import '../../../data/user_item.dart';
import '../../../globals.dart';

// TODO: move to assets folder
const _defaultUserPicture = 'default_user.png';

class UserAvatar extends StatelessWidget {
  final UserItem? item;

  const UserAvatar({required this.item});

  @override
  Widget build(BuildContext context) {
    if (item != null && item!.avatar == null) {
      // user with no pic - show initials
      return InitialsAvatar(user: item!);
    }

    return AspectRatio(
      aspectRatio: 1,
      child: ClipOval(
        child: AppImage(
          assetName: '$imagesPath/${item?.avatar ?? _defaultUserPicture}',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
