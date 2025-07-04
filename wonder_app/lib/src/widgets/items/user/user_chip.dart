import 'package:flutter/material.dart' hide Chip;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wonder/src/widgets/items/item_chip.dart';

import '../../../data/user_item.dart';
import '../../../providers/users_provider.dart';
import 'user_avatar.dart';

class UserChip extends StatelessWidget {
  final UserItem? item;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final TextStyle? labelStyle;
  final double? height;
  final double? width;

  const UserChip({
    required this.item,
    this.backgroundColor,
    this.padding,
    this.borderRadius,
    this.labelStyle,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return ItemChip(
      item: item,
      itemType: 'user',
      avatar: UserAvatar(item: item),
      padding: padding,
      labelStyle: labelStyle,
      height: height,
      width: width,
    );
  }
}

class UserChipConsumer extends ConsumerWidget {
  final String? id;
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
    final user = id != null ? ref.watch(userProvider(id!)) : null;

    return UserChip(
      item: user,
      backgroundColor: backgroundColor,
      height: height,
      width: width,
      padding: padding,
      borderRadius: borderRadius,
      labelStyle: labelStyle,
    );
  }
}
