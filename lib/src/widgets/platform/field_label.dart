import 'package:flutter/material.dart';

import 'constants.dart';

enum LabelPosition {
  top,
  left,
}

class FieldLabel extends StatelessWidget {
  final String label;
  final Widget child;
  final LabelPosition position;
  final double? spacing;

  const FieldLabel({
    required this.label,
    required this.child,
    this.position = LabelPosition.top,
    this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    return Flex(
      crossAxisAlignment: CrossAxisAlignment.start,
      direction: position == LabelPosition.top ? Axis.vertical : Axis.horizontal,
      spacing: spacing ?? kFieldLabelSpacing,
      children: [
        Text(label, style: Theme.of(context).inputDecorationTheme.labelStyle),
        child,
      ],
    );
  }
}
