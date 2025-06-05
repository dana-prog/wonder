import 'package:flutter/material.dart' as m;

import '../../utils/color_utils.dart';

class Chip extends m.StatelessWidget {
  final String label;
  final m.Widget? avatar;
  final m.TextStyle? labelStyle;
  final m.Color? backgroundColor;
  final double? height;
  final double? width;
  final m.EdgeInsetsGeometry? padding;
  final m.OutlinedBorder? shape;

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
  m.Widget build(m.BuildContext context) {
    return m.Chip(
      // adding a container to wrap the label in order to set width and height
      label: m.Container(
        width: width,
        height: height,
        decoration: m.BoxDecoration(color: backgroundColor),
        child: m.Center(child: m.Text(label)),
      ),
      avatar: avatar,
      labelStyle: applyOnColor(labelStyle, backgroundColor),
      backgroundColor: backgroundColor,
      padding: padding,
      // set to shrinkWrap to avoid extra padding around the chip
      // materialTapTargetSize: m.MaterialTapTargetSize.shrinkWrap,
      // shape: m.RoundedRectangleBorder(
      //   borderRadius: m.BorderRadius.circular(10.0),
      // ),
    );
  }
}
