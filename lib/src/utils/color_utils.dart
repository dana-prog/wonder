import 'dart:ui';

import '../theme/app_theme.dart';

Color getOnColor(Color background) {
  final brightness = estimateBrightnessForColor(background);
  final theme = (brightness == Brightness.light) ? AppTheme.light : AppTheme.dark;
  return theme.colorScheme.onSurface;
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
