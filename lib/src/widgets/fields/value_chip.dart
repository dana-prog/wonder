import 'package:flutter/material.dart';
import 'package:wonder/src/data/list_value_item.dart';

const _defaultPadding = EdgeInsets.symmetric(horizontal: 8, vertical: 2);
const _defaultBorderRadius = BorderRadius.all(Radius.circular(6));
const _defaultFontSize = 14.0;
const _defaultFontWeight = FontWeight.w600;

class ListValueField extends StatelessWidget {
  final ListValueItem listValueItem;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final TextStyle? textStyle;

  const ListValueField({
    required this.listValueItem,
    this.height,
    this.width,
    this.padding,
    this.borderRadius,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) => ValueChip(
        textStyle: textStyle,
        label: listValueItem.title,
        backgroundColor: listValueItem.color,
        height: height,
        width: width,
      );
}

class ValueChip extends StatelessWidget {
  final String label;
  final WidgetBuilder? leadingBuilder;
  final Color? backgroundColor;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final TextStyle? textStyle;

  const ValueChip({
    required this.label,
    this.leadingBuilder,
    this.backgroundColor,
    this.padding,
    this.borderRadius,
    this.textStyle,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius ?? _defaultBorderRadius,
        ),
        child: Padding(
          padding: padding ?? _defaultPadding,
          child: leadingBuilder != null
              ? Row(
                  spacing: 8,
                  children: [
                    leadingBuilder!(context),
                    titleBuilder(context),
                  ],
                )
              : titleBuilder(context),
        ),
      ),
    );
  }

  Widget titleBuilder(BuildContext context) => Text(
        label,
        textAlign: TextAlign.center,
        style: getEffectiveTextStyle(context),
      );

  TextStyle? getEffectiveTextStyle(BuildContext context) {
    final defaultTextStyle = TextStyle(
      fontSize: _defaultFontSize,
      fontWeight: _defaultFontWeight,
      color: backgroundColor == null ? Colors.black : Colors.white,
    );
    return (textStyle != null && textStyle!.inherit)
        ? defaultTextStyle.merge(textStyle)
        : defaultTextStyle;
  }
}
