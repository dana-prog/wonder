import 'package:auto_size_text_plus/auto_size_text_plus.dart';
import 'package:flutter/material.dart';

import '../../../data/user_item.dart';
import '../../../theme/app_theme.dart';

class InitialsAvatar extends StatelessWidget {
  final UserItem user;

  const InitialsAvatar({required this.user});

  @override
  Widget build(BuildContext context) {
    final color = getInitialsColor();
    return AspectRatio(
      aspectRatio: 1,
      child: ClipOval(
        child: Container(
          color: color,
          padding: const EdgeInsets.all(3),
          // width: 48,
          // height: 48,
          alignment: Alignment.center,
          child: AutoSizeText(
            getInitialsChars(),
            // default minFontSize is 12, but we want to allow smaller sizes fo the initials avatar
            minFontSize: 8,
            style: TextStyle(
                color: AppTheme.dark.colorScheme.onSurface, fontWeight: FontWeight.normal),
          ),
        ),
      ),
    );
    // return CircleAvatar(
    //   // specify minRadius to prevent CircleAvatar from applying minimum width to the widget (see CircleAvatar._minDiameter and _defaultMinRadius)
    //   // minRadius: 0,
    //   backgroundColor: color,
    //   // child: Padding(
    //   // TODO: remove hard coded value
    //   // padding: EdgeInsets.all(3),
    //   // use AutoSizeText to allow the initials to shrink if needed
    //   child: AutoSizeText(
    //     getInitialsChars(),
    //     // default minFontSize is 12, but we want to allow smaller sizes fo the initials avatar
    //     minFontSize: 8,
    //     style: TextStyle(color: AppTheme.dark.colorScheme.onSurface, fontWeight: FontWeight.normal),
    //   ),
    //   // ),
    // );
  }

  // TODO: use also middle name and nickname if needed
  String getInitialsChars() {
    final firstNameInitial =
        user.firstName.isNotEmpty ? user.firstName.substring(0, 1).toUpperCase() : '';
    final lastNameInitial =
        user.lastName.isNotEmpty ? user.lastName.substring(0, 1).toUpperCase() : '';
    return '$firstNameInitial$lastNameInitial';
  }

  Color getInitialsColor() {
    // TODO: check performance
    final hash = user.title.hashCode;
    final color = Colors.primaries[hash % Colors.primaries.length];
    return color.shade700;
  }
}
