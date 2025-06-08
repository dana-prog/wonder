import 'package:flutter/material.dart' hide Chip;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wonder/src/resources/colors.dart';
import 'package:wonder/src/resources/labels.dart';

import '../../data/item.dart';
import '../../providers/items_provider.dart';
import '../platform/chip.dart';
import '../platform/error_view.dart';

class ItemChip extends StatelessWidget {
  final Item? item;
  final String? itemType;
  final Widget? avatar;
  final TextStyle? labelStyle;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? width;

  const ItemChip({
    required this.item,
    this.itemType,
    this.avatar,
    this.labelStyle,
    this.padding,
    this.height,
    this.width,
  }) : assert(item != null || itemType != null,
            'Either item or itemType must be provided. If item is null, itemType must be provided to fetch the item.');

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: item?.title ?? Labels.noItem(itemType!),
      avatar: avatar,
      backgroundColor: getItemColor(item),
      labelStyle: labelStyle,
      padding: padding,
      height: height,
      width: width,
    );
  }
}

class ItemChipConsumer extends ConsumerWidget {
  final String itemType;
  final String id;
  final Widget? avatar;
  final TextStyle? labelStyle;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final double? width;

  const ItemChipConsumer({
    required this.itemType,
    required this.id,
    this.avatar,
    this.labelStyle,
    this.padding,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncItem = ref.watch(itemProvider((itemType, id)));
    return asyncItem.when(
      data: (item) {
        return ItemChip(
            item: item,
            itemType: itemType,
            avatar: avatar,
            labelStyle: labelStyle,
            padding: padding,
            height: height,
            width: width);
      },
      error: ErrorView.new,
      loading: () => ItemChipLoading(),
    );
  }
}

class ItemChipLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator();
  }
}
