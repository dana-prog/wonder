import 'package:flutter/material.dart';
import 'package:wonder/src/data/user_item.dart';

import '../../resources/labels.dart';
import '../fields/value_chip.dart';

const _defaultPadding = EdgeInsets.all(0);
const _defaultTitleFontSize = 14.0;
const _defaultInitialsColor = Colors.white;

class UserChip extends StatelessWidget {
  final UserItem? user;
  final Color? backgroundColor;
  final String? pictureUrl;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final TextStyle? textStyle;

  UserChip({
    required this.user,
    this.backgroundColor,
    this.pictureUrl,
    this.padding,
    this.borderRadius,
    this.textStyle,
    this.height,
    this.width,
  }) : super(key: ValueKey(user?.id));

  @override
  Widget build(BuildContext context) {
    final effectiveTextStyle = TextStyle(fontSize: _defaultTitleFontSize).merge(textStyle);
    return ValueChip(
      label: title,
      leadingBuilder: (BuildContext context) {
        if (user != null && user!.picture != null) {
          return CircleAvatar(backgroundImage: NetworkImage(user!.picture!));
        }
        return CircleAvatar(
          backgroundColor: getInitialsColor(),
          minRadius: 12,
          child: Text(
            getInitialsChars(),
            style: getInitialsEffectiveTextStyle(effectiveTextStyle),
          ),
        );
      },
      padding: padding ?? _defaultPadding,
      backgroundColor: backgroundColor,
      textStyle: effectiveTextStyle,
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
    final hash = title.hashCode;
    final color = Colors.primaries[hash % Colors.primaries.length];
    return color.shade700;
  }

  TextStyle getInitialsEffectiveTextStyle(TextStyle textStyle) {
    final defaultStyle = TextStyle(color: _defaultInitialsColor);
    // initials font should be a bit smaller than the text size
    final fontSize = (textStyle.fontSize ?? _defaultTitleFontSize) - 2.0;

    return defaultStyle.merge(textStyle).copyWith(fontSize: fontSize);
  }
}
