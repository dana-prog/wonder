import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/lists_of_values_provider.dart';
import '../fields/item_chip.dart';

class ListValueChipConsumer extends ConsumerWidget {
  final String id;
  final Color? backgroundColor;
  final String? pictureUrl;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final TextStyle? labelStyle;

  const ListValueChipConsumer({
    required this.id,
    this.backgroundColor,
    this.pictureUrl,
    this.height,
    this.width,
    this.padding,
    this.borderRadius,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(listValueProvider(id));

    return ItemChip(
      item: item,
      height: height,
      width: width,
      padding: padding,
      borderRadius: borderRadius,
      labelStyle: labelStyle,
    );
  }
}
