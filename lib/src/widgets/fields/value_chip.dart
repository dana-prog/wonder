import 'package:flutter/material.dart';
import 'package:wonder/src/data/list_value_item.dart';

class ListValueField extends StatelessWidget {
  final ListValueItem listValueItem;
  final ValueChipSize? size;

  const ListValueField({
    required this.listValueItem,
    this.size,
  });

  @override
  Widget build(BuildContext context) => ValueChip(
        title: listValueItem.title,
        color: listValueItem.color,
        size: size,
      );
}

enum ValueChipSize {
  small,
  medium,
  large,
}

class ValueChip extends StatelessWidget {
  final String title;
  final Color color;
  final ValueChipSize size;

  const ValueChip({
    required this.title,
    required this.color,
    ValueChipSize? size,
  }) : size = size ?? ValueChipSize.small;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius,
        ),
        child: Padding(
          padding: padding,
          child: Text(
            title == 'Not Started' ? 'Started' : title,
            textAlign: TextAlign.center,
            style: getTextStyle(context),
          ),
        ),
      );

  EdgeInsetsGeometry get padding {
    switch (size) {
      case ValueChipSize.small:
        return EdgeInsets.symmetric(horizontal: 8, vertical: 4);
      case ValueChipSize.medium:
        return EdgeInsets.symmetric(horizontal: 10, vertical: 6);
      case ValueChipSize.large:
        return EdgeInsets.symmetric(horizontal: 12, vertical: 8);
    }
  }

  BorderRadius get borderRadius => BorderRadius.circular(6);

  TextStyle getTextStyle(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    TextStyle? textStyle;

    switch (size) {
      case ValueChipSize.small:
        textStyle = textTheme.labelSmall;
        break;
      case ValueChipSize.medium:
        textStyle = textTheme.bodyMedium;
        break;
      case ValueChipSize.large:
        textStyle = textTheme.bodyLarge;
        break;
    }

    return (textStyle ?? DefaultTextStyle.of(context).style).copyWith(
      color: Colors.white,
      fontWeight: size == ValueChipSize.small ? FontWeight.w600 : FontWeight.bold,
    );
  }
}
