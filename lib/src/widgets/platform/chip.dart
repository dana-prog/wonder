import 'package:flutter/material.dart';
import 'package:wonder/src/widgets/platform/overrides/material_chip.dart';

import '../../utils/color_utils.dart';

class Chip extends StatelessWidget {
  final String label;
  final Widget? avatar;
  final TextStyle? labelStyle;
  final Color? backgroundColor;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final OutlinedBorder? shape;

  const Chip({
    required this.label,
    this.avatar,
    this.labelStyle,
    this.backgroundColor,
    this.padding,
    this.height,
    this.width,
    this.shape,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialChip(
      // adding a container to wrap the label in order to set width and height
      label: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
        ),
        child: Center(child: Text(label)),
      ),
      avatar: avatar,
      labelStyle: getLabelStyle(context),
      backgroundColor: backgroundColor,
      padding: padding,
      // set to shrinkWrap to avoid extra padding around the chip
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: const StadiumBorder(),
      // shape: shape,
    );
  }

  TextStyle? getLabelStyle(BuildContext context) {
    if (backgroundColor == null) {
      return labelStyle;
    }

    final color = getOnColor(backgroundColor!);
    return TextStyle(color: color).merge(labelStyle);
  }
}
