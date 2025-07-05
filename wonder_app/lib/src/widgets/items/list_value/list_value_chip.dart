import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/lists_values_provider.dart';
import '../item_chip.dart';

class ListValueChipConsumer extends ConsumerWidget {
  final String id;
  final Color? backgroundColor;
  final TextStyle? labelStyle;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? width;
  final TextAlign? textAlign;

  const ListValueChipConsumer({
    required this.id,
    this.backgroundColor,
    this.labelStyle,
    this.padding,
    this.height,
    this.width,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(listValueProvider(id));

    return ItemChip(
      item: item,
      labelStyle: labelStyle,
      padding: padding,
      height: height,
      width: width,
      textAlign: textAlign,
    );
  }
}
