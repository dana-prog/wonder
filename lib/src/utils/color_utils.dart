import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

Color getOnColor(Color background) {
  final brightness = estimateBrightnessForColor(background);
  return (brightness == Brightness.light)
      ? AppTheme.light.colorScheme.onSurfaceVariant
      : AppTheme.dark.colorScheme.onSurface;
}

Brightness estimateBrightnessForColor(Color color) {
  final double relativeLuminance = color.computeLuminance();

  const double kThreshold = 0.3;
  // const double kThreshold = 0.15;
  if ((relativeLuminance + 0.05) * (relativeLuminance + 0.05) > kThreshold) {
    return Brightness.light;
  }
  return Brightness.dark;
}

TextStyle? applyOnColor(TextStyle? defaultStyle, Color? backgroundColor) {
  if (backgroundColor == null) {
    return defaultStyle;
  }

  final color = getOnColor(backgroundColor);
  return TextStyle(color: color).merge(defaultStyle);
}
