import 'package:flutter/material.dart';
import 'package:wonder/src/data/list_value_item.dart';

class ListValueField extends StatelessWidget {
  final ListValueItem listValueItem;
  final ValueChipSize? size;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final TextStyle? textStyle;

  const ListValueField({
    required this.listValueItem,
    this.size,
    this.height,
    this.width,
    this.padding,
    this.borderRadius,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) => ValueChip(
        title: listValueItem.title,
        color: listValueItem.color,
        size: size,
        height: height,
        width: width,
      );
}

enum ValueChipSize {
  small,
  medium,
  large,
}

const _defaultPadding = EdgeInsets.symmetric(horizontal: 8, vertical: 4);
const _defaultBorderRadius = BorderRadius.all(Radius.circular(6));
const _defaultTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w500,
);

class ValueChip extends StatelessWidget {
  final String title;
  final Color color;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final TextStyle? textStyle;

  const ValueChip({
    required this.title,
    required this.color,
    this.padding,
    this.borderRadius,
    this.textStyle,
    this.height,
    this.width,
    ValueChipSize? size,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        height: height,
        width: width,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: borderRadius ?? _defaultBorderRadius,
          ),
          child: Padding(
            padding: padding ?? _defaultPadding,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: textStyle ?? _defaultTextStyle,
            ),
          ),
        ),
      );
}
