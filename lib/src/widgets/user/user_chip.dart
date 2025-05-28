import 'package:flutter/material.dart';
import 'package:wonder/src/data/user_item.dart';

import '../../resources/labels.dart';
import '../fields/value_chip.dart';

const _defaultPadding = EdgeInsets.all(0);
const _defaultTitleFontSize = 14.0;
const _defaultInitialsColor = Colors.white;
// TODO: remove hard coded value
const _minRadius = 12.0;

class UserChip extends StatelessWidget {
  final UserItem? user;
  final Color? backgroundColor;
  final String? pictureUrl;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final TextStyle? labelStyle;

  UserChip({
    required this.user,
    this.backgroundColor,
    this.pictureUrl,
    this.padding,
    this.borderRadius,
    this.labelStyle,
    this.height,
    this.width,
  }) : super(key: ValueKey(user?.id));

  @override
  Widget build(BuildContext context) {
    return ValueChip(
      label: title,
      leadingBuilder: (BuildContext context) {
        if (user != null && user!.picture != null) {
          return CircleAvatar(backgroundImage: NetworkImage(user!.picture!), minRadius: _minRadius);
        }
        return CircleAvatar(
          backgroundColor: getInitialsColor(),
          minRadius: _minRadius,
          child: Text(
            getInitialsChars(),
            style: getInitialsEffectiveTextStyle(context),
          ),
        );
      },
      padding: padding ?? _defaultPadding,
      backgroundColor: backgroundColor,
      labelStyle: getEffectiveLabelStyle(context),
      borderRadius: borderRadius,
      height: height,
      width: width,
    );
  }

  String getInitialsChars() {
    String text = user != null ? '${user!.firstName} ${user!.lastName}' : Labels.noUser;

    final parts = text.trim().split(RegExp(r'\s+'));
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }

  String get title => user?.title ?? Labels.noUser;

  Color getInitialsColor() {
    // final hash = title.hashCode;
    // final color = Colors.primaries[hash % Colors.primaries.length];
    // return color.shade700;
    return Colors.primaries[5].shade700;
  }

  TextStyle getEffectiveLabelStyle(BuildContext context) =>
      TextStyle(fontSize: _defaultTitleFontSize).merge(labelStyle);

  TextStyle getInitialsEffectiveTextStyle(BuildContext context) {
    final labelStyle = getEffectiveLabelStyle(context);

    // initials font should be a bit smaller than the text size
    final fontSize = labelStyle.fontSize! - 3.0;

    return labelStyle.copyWith(color: _defaultInitialsColor, fontSize: fontSize);
  }
}
