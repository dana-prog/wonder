import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const defaultBorderRadius = 10.0;

/// The [AppTheme] defines light and dark themes for the app.
///
/// Theme setup for FlexColorScheme package v8.
/// Use same major flex_color_scheme package version. If you use a
/// lower minor version, some properties may not be supported.
/// In that case, remove them after copying this theme to your
/// app or upgrade the package to version 8.2.0.
///
/// Use it in a [MaterialApp] like this:
///
/// MaterialApp(
///   theme: AppTheme.light,
///   darkTheme: AppTheme.dark,
/// );
abstract final class AppTheme {
  // The FlexColorScheme defined light mode ThemeData.
  static ThemeData light = FlexThemeData.light(
    // Using FlexColorScheme built-in FlexScheme enum based colors
    scheme: FlexScheme.flutterDash,
    // Component theme configurations for light mode.
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
    ),
    // Direct ThemeData properties.
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
    useMaterial3: false,
  );

  // The FlexColorScheme defined dark mode ThemeData.
  static ThemeData dark = FlexThemeData.dark(
    // Using FlexColorScheme built-in FlexScheme enum based colors.
    scheme: FlexScheme.flutterDash,
    // Component theme configurations for dark mode.
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      blendOnColors: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
    ),
    // Direct ThemeData properties.
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
    useMaterial3: false,
  );
}

// TODO: AppTheme.light
ThemeData getLightTheme() {
  return FlexThemeData.light(
    // Using FlexColorScheme built-in FlexScheme enum based colors
    scheme: FlexScheme.flutterDash,
    // Component theme configurations for light mode.
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: false,
      inputDecoratorBorderType: FlexInputBorderType.underline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
    ),
    // Direct ThemeData properties.
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),

    useMaterial3: true,
  ).copyWith(
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        padding: EdgeInsets.all(4),
        minimumSize: Size.zero,
        visualDensity: VisualDensity.compact,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    ),
  );
}

// abstract final class AppTheme {
//   // The defined light theme.
//   static ThemeData light = FlexThemeData.light(
//     scheme: FlexScheme.sanJuanBlue,
//     appBarStyle: FlexAppBarStyle.material,
//     subThemesData: const FlexSubThemesData(
//       interactionEffects: true,
//       tintedDisabledControls: true,
//       useM2StyleDividerInM3: true,
//       inputDecoratorIsFilled: true,
//       inputDecoratorBorderType: FlexInputBorderType.outline,
//       alignedDropdown: true,
//       navigationRailUseIndicator: true,
//       navigationRailLabelType: NavigationRailLabelType.all,
//     ),
//     keyColors: const FlexKeyColors(
//       useSecondary: true,
//       useTertiary: true,
//       useError: true,
//     ),
//     tones: FlexSchemeVariant.material.tones(Brightness.light),
//     visualDensity: FlexColorScheme.comfortablePlatformDensity,
//   );
//   // The defined dark theme.
//   static ThemeData dark = FlexThemeData.dark(
//     scheme: FlexScheme.sanJuanBlue,
//     subThemesData: const FlexSubThemesData(
//       interactionEffects: true,
//       tintedDisabledControls: true,
//       blendOnColors: true,
//       useM2StyleDividerInM3: true,
//       inputDecoratorIsFilled: true,
//       inputDecoratorBorderType: FlexInputBorderType.outline,
//       alignedDropdown: true,
//       navigationRailUseIndicator: true,
//       navigationRailLabelType: NavigationRailLabelType.all,
//     ),
//     keyColors: const FlexKeyColors(
//       useSecondary: true,
//       useTertiary: true,
//       useError: true,
//     ),
//     tones: FlexSchemeVariant.material.tones(Brightness.dark),
//     visualDensity: FlexColorScheme.comfortablePlatformDensity,
//   );
// }
