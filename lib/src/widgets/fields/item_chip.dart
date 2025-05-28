import 'package:flutter/material.dart' hide Chip;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wonder/src/widgets/async/async_value_widget.dart';

import '../../data/item.dart';
import '../../providers/items_provider.dart';
import '../fields/chip.dart';

class ItemChip extends StatelessWidget {
  final Item item;
  final WidgetBuilder? leadingBuilder;
  final TextStyle? labelStyle;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final double? height;
  final double? width;

  const ItemChip({
    required this.item,
    this.leadingBuilder,
    this.labelStyle,
    this.padding,
    this.borderRadius,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: item.title,
      backgroundColor: item.color,
      leadingBuilder: leadingBuilder,
      labelStyle: labelStyle,
      padding: padding,
      borderRadius: borderRadius,
      height: height,
      width: width,
    );
  }
}

class ItemChipConsumer extends ConsumerWidget {
  final String itemType;
  final String id;
  final WidgetBuilder? leadingBuilder;
  final TextStyle? labelStyle;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;

  const ItemChipConsumer({
    required this.itemType,
    required this.id,
    this.leadingBuilder,
    this.labelStyle,
    this.padding,
    this.borderRadius,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncItem = ref.watch(itemProvider((itemType, id)));
    return AsyncValueWidget(
        asyncValue: asyncItem,
        dataBuilder: (item, _) {
          return ItemChip(item: item);
        });
  }
}
