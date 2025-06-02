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
    return CircleAvatar(
      backgroundColor: color,
      child: AutoSizeText(
        getInitialsChars(),
        style: TextStyle(color: AppTheme.dark.colorScheme.onSurface),
      ),
    );
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
