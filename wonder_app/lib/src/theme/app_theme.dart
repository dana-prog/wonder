import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

// TODO: remove hard coded value (used in image manager)
const defaultBorderRadius = 10.0;

abstract final class AppTheme {
  static ThemeData light = _getLightTheme();

  static ThemeData dark = _getDarkTheme();
}

ThemeData _getLightTheme() {
  return FlexThemeData.light(
    scheme: FlexScheme.flutterDash,
    useMaterial3: true,
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    // Component theme configurations for light mode.
    subThemesData: const FlexSubThemesData(
      // inputDecoratorRadius: defaultBorderRadius,
      // inputDecoratorBorderSchemeColor: SchemeColor.transparent,
      // inputDecoratorBorderType: FlexInputBorderType.outline,
      chipPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      // chipRadius,
      // chipBlendColors,
      // chipSchemeColor,
      // chipSelectedSchemeColor,
      // chipSecondarySelectedSchemeColor,
      // chipDeleteIconSchemeColor,
      // chipLabelStyle,
      // chipSecondaryLabelStyle,
      // chipFontSize,
      // chipSecondaryFontSize,
      // chipIconSize,
      // chipPadding,
    ),
    // cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );
}

ThemeData _getDarkTheme() {
  return FlexThemeData.dark(
    scheme: FlexScheme.flutterDash,
    useMaterial3: true,
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    // Component theme configurations for dark mode.
    subThemesData: const FlexSubThemesData(
      chipPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      // chipRadius,
      // chipBlendColors,
      // chipSchemeColor,
      // chipSelectedSchemeColor,
      // chipSecondarySelectedSchemeColor,
      // chipDeleteIconSchemeColor,
      // chipLabelStyle,
      // chipSecondaryLabelStyle,
      // chipFontSize,
      // chipSecondaryFontSize,
      // chipIconSize,
      // chipPadding,
    ),
    // cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );
}
