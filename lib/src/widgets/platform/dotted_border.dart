import 'package:dotted_border/dotted_border.dart' as db;
import 'package:flutter/material.dart';

import '../../app_theme.dart';

class DottedBorder extends StatelessWidget {
  final Widget child;

  const DottedBorder({required this.child});

  @override
  Widget build(BuildContext context) {
    return db.DottedBorder(
      options: db.RoundedRectDottedBorderOptions(
        radius: const Radius.circular(defaultBorderRadius),
        color: Colors.grey.shade600,
        dashPattern: const <double>[1, 2],
      ),
      child: child,
    );
  }
}
