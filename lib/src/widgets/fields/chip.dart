import 'package:flutter/material.dart';

const _defaultPadding = EdgeInsets.symmetric(horizontal: 8, vertical: 2);
const _defaultTextAlign = TextAlign.center;
const _defaultBorderRadius = BorderRadius.all(Radius.circular(10.0));
const _defaultFontSize = 14.0;
const _defaultFontWeight = FontWeight.w600;

// not using material Chip since it has fixed minimum chip height (const double _kChipHeight = 32.0)
class Chip extends StatelessWidget {
  final String label;
  final WidgetBuilder? leadingBuilder;
  final TextStyle? labelStyle;
  final Color? backgroundColor;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;

  const Chip({
    required this.label,
    this.leadingBuilder,
    this.labelStyle,
    this.backgroundColor,
    this.padding,
    this.borderRadius,
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
          // TODO: resolve padding
          padding: padding ?? _defaultPadding,
          child: leadingBuilder != null
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 8,
                  children: [
                    leadingBuilder!(context),
                    labelBuilder(context),
                  ],
                )
              : labelBuilder(context),
        ),
      ),
    );
  }

  Widget labelBuilder(BuildContext context) => Text(
        label,
        textAlign: _defaultTextAlign,
        style: getEffectiveTextStyle(context),
      );

  TextStyle? getEffectiveTextStyle(BuildContext context) {
    final defaultTextStyle = TextStyle(
      fontSize: _defaultFontSize,
      fontWeight: _defaultFontWeight,
      color: backgroundColor == null ? Colors.black : Colors.white,
    );
    return (labelStyle != null && labelStyle!.inherit)
        ? defaultTextStyle.merge(labelStyle)
        : defaultTextStyle;
  }
}
