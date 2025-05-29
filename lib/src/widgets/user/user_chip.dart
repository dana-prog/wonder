import 'package:flutter/material.dart' hide Chip;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wonder/src/data/user_item.dart';

import '../../data/item_helpers.dart';
import '../../providers/users_provider.dart';
import '../../resources/labels.dart';
import '../fields/chip.dart';

const _userPicture = '$mediaPublicUrlPrefix/1246fe_7609a78c62784e4788f3fb2c6a65fb95~mv2.png';
const _defaultPadding = EdgeInsets.all(0);
const _defaultTitleFontSize = 14.0;
const _defaultInitialsColor = Colors.white;
// TODO: remove hard coded value
const _minRadius = 12.0;

class UserChip extends StatelessWidget {
  final UserItem? user;
  final Color? backgroundColor;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final TextStyle? labelStyle;

  const UserChip({
    required this.user,
    this.backgroundColor,
    this.padding,
    this.borderRadius,
    this.labelStyle,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: user?.title ?? Labels.noItem('user'),
      leadingBuilder: leadingBuilder,
      padding: padding ?? _defaultPadding,
      backgroundColor: backgroundColor,
      labelStyle: getEffectiveLabelStyle(context),
      borderRadius: borderRadius,
      height: height,
      width: width,
    );
  }

  Widget leadingBuilder(BuildContext context) {
    if (user == null) {
      return CircleAvatar(
        radius: _minRadius,
        backgroundImage: NetworkImage(_userPicture),
      );
    }

    if (user!.picture == null) {
      return CircleAvatar(
        radius: _minRadius,
        backgroundColor: getInitialsColor(),
        child: Text(
          getInitialsChars(),
          style: getInitialsEffectiveTextStyle(context),
        ),
      );
    }

    return CircleAvatar(
      radius: _minRadius,
      backgroundImage: NetworkImage(user!.picture!),
    );
  }

  String getInitialsChars() {
    String text = user != null ? '${user!.firstName} ${user!.lastName}' : '';

    final parts = text.trim().split(RegExp(r'\s+'));
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }

  Color getInitialsColor() {
    // TODO: check performance
    final hash = user?.title.hashCode ?? ''.hashCode;
    final color = Colors.primaries[hash % Colors.primaries.length];
    return color.shade700;
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

class UserChipConsumer extends ConsumerWidget {
  final String id;
  final Color? backgroundColor;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final TextStyle? labelStyle;

  const UserChipConsumer({
    required this.id,
    this.backgroundColor,
    this.height,
    this.width,
    this.padding,
    this.borderRadius,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider(id));

    return UserChip(
      user: user,
      backgroundColor: backgroundColor,
      height: height,
      width: width,
      padding: padding,
      borderRadius: borderRadius,
      labelStyle: labelStyle,
    );
  }
}
