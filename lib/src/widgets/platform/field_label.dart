import 'package:flutter/material.dart';

const spacing = 6.0;

class FieldLabel extends StatelessWidget {
  final String label;
  final Widget child;

  const FieldLabel({
    required this.label,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spacing,
      children: [
        Text(label, style: Theme.of(context).inputDecorationTheme.labelStyle),
        child,
      ],
    );
  }
}
