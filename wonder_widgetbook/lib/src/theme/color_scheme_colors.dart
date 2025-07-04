import 'package:flutter/material.dart';

import 'color_card.dart';

class ColorSchemeColors extends StatelessWidget {
  const ColorSchemeColors({
    super.key,
    this.onBackgroundColor,
    this.showTitle = true,
  });

  /// The color of the background the color widget are being drawn on.
  ///
  /// Some of the theme colors may have semi transparent fill color. To compute
  /// a legible text color for the sum when it shown on a background color, we
  /// need to alpha merge it with background and we need the exact background
  /// color it is drawn on for that. If not passed in from parent, it is
  /// assumed to be drawn on card color, which usually is close enough.
  final Color? onBackgroundColor;

  /// Show the title.
  ///
  /// Defaults to true.
  final bool showTitle;

  // Return true if the color is light, meaning it needs dark text for contrast.
  static bool _isLight(final Color color) =>
      ThemeData.estimateBrightnessForColor(color) == Brightness.light;

  // Return true if the color is dark, meaning it needs light text for contrast.
  static bool _isDark(final Color color) =>
      ThemeData.estimateBrightnessForColor(color) == Brightness.dark;

  // On color used when a theme color property does not have a theme onColor.
  static Color _onColor(final Color color, final Color bg) =>
      _isLight(Color.alphaBlend(color, bg)) ? Colors.black : Colors.white;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final bool isDark = colorScheme.brightness == Brightness.dark;
    final bool useMaterial3 = theme.useMaterial3;
    final TextStyle headerStyle = theme.textTheme.titleMedium!;

    // final Size mediaSize = MediaQuery.sizeOf(context);
    // final bool isPhone = mediaSize.width < App.phoneWidthBreakpoint ||
    //     mediaSize.height < App.phoneHeightBreakpoint;
    // final double spacing = isPhone ? 3 : 6;
    final double spacing = 6;

    // Grab the card border from the theme card shape
    ShapeBorder? border = theme.cardTheme.shape;
    // If we had one, copy in a border side to it.
    if (border is RoundedRectangleBorder) {
      border = border.copyWith(
        side: BorderSide(
          color: theme.dividerColor,
          width: 1,
        ),
      );
      // If
    } else {
      // If border was null, make one matching Card default, but with border
      // side, if it was not null, we leave it as it was.
      border ??= RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(useMaterial3 ? 12 : 4)),
        side: BorderSide(
          color: theme.dividerColor,
          width: 1,
        ),
      );
    }

    // Get effective background color.
    final Color background = onBackgroundColor ?? theme.cardTheme.color ?? theme.cardColor;

    // Warning label for scaffold background when it uses to much blend.
    final String surfaceTooHigh = isDark
        ? _isLight(theme.colorScheme.surface)
            ? '\nTOO HIGH'
            : ''
        : _isDark(theme.colorScheme.surface)
            ? '\nTOO HIGH'
            : '';

    // Warning label for scaffold background when it uses to much blend.
    // final String backTooHigh = isDark
    //     ? _isLight(theme.colorScheme.background)
    //         ? '\nTOO HIGH'
    //         : ''
    //     : _isDark(theme.colorScheme.background)
    //         ? '\nTOO HIGH'
    //         : '';

    // Wrap this widget branch in a custom theme where card has a border outline
    // if it did not have one, but retains in ambient themed border radius.
    return Theme(
      data: theme.copyWith(
        cardTheme: CardTheme.of(context).copyWith(
          elevation: 0,
          shape: border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (showTitle)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text('ColorScheme colors', style: headerStyle),
            ),
          Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: spacing,
            runSpacing: spacing,
            children: <Widget>[
              ColorCard(
                label: 'Primary',
                color: colorScheme.primary,
                textColor: colorScheme.onPrimary,
              ),
              ColorCard(
                label: 'on\nPrimary',
                color: colorScheme.onPrimary,
                textColor: colorScheme.primary,
              ),
              ColorCard(
                label: 'Primary\nContainer',
                color: colorScheme.primaryContainer,
                textColor: colorScheme.onPrimaryContainer,
              ),
              ColorCard(
                label: 'on\nPrimary\nContainer',
                color: colorScheme.onPrimaryContainer,
                textColor: colorScheme.primaryContainer,
              ),
              ColorCard(
                label: 'Primary\nFixed',
                color: colorScheme.primaryFixed,
                textColor: colorScheme.onPrimaryFixed,
              ),
              ColorCard(
                label: 'on\nPrimary\nFixed',
                color: colorScheme.onPrimaryFixed,
                textColor: colorScheme.primaryFixed,
              ),
              ColorCard(
                label: 'Primary\nFixedDim',
                color: colorScheme.primaryFixedDim,
                textColor: colorScheme.onPrimaryFixedVariant,
              ),
              ColorCard(
                label: 'on\nPrimary\nFixedVariant',
                color: colorScheme.onPrimaryFixedVariant,
                textColor: colorScheme.primaryFixedDim,
              ),
              ColorCard(
                label: 'Secondary',
                color: colorScheme.secondary,
                textColor: colorScheme.onSecondary,
              ),
              ColorCard(
                label: 'on\nSecondary',
                color: colorScheme.onSecondary,
                textColor: colorScheme.secondary,
              ),
              ColorCard(
                label: 'Secondary\nContainer',
                color: colorScheme.secondaryContainer,
                textColor: colorScheme.onSecondaryContainer,
              ),
              ColorCard(
                label: 'on\nSecondary\nContainer',
                color: colorScheme.onSecondaryContainer,
                textColor: colorScheme.secondaryContainer,
              ),
              ColorCard(
                label: 'Secondary\nFixed',
                color: colorScheme.secondaryFixed,
                textColor: colorScheme.onSecondaryFixed,
              ),
              ColorCard(
                label: 'on\nSecondary\nFixed',
                color: colorScheme.onSecondaryFixed,
                textColor: colorScheme.secondaryFixed,
              ),
              ColorCard(
                label: 'Secondary\nFixedDim',
                color: colorScheme.secondaryFixedDim,
                textColor: colorScheme.onSecondaryFixedVariant,
              ),
              ColorCard(
                label: 'on\nSecondary\nFixedVariant',
                color: colorScheme.onSecondaryFixedVariant,
                textColor: colorScheme.secondaryFixedDim,
              ),
              ColorCard(
                label: 'Tertiary',
                color: colorScheme.tertiary,
                textColor: colorScheme.onTertiary,
              ),
              ColorCard(
                label: 'on\nTertiary',
                color: colorScheme.onTertiary,
                textColor: colorScheme.tertiary,
              ),
              ColorCard(
                label: 'Tertiary\nContainer',
                color: colorScheme.tertiaryContainer,
                textColor: colorScheme.onTertiaryContainer,
              ),
              ColorCard(
                label: 'on\nTertiary\nContainer',
                color: colorScheme.onTertiaryContainer,
                textColor: colorScheme.tertiaryContainer,
              ),
              ColorCard(
                label: 'Tertiary\nFixed',
                color: colorScheme.tertiaryFixed,
                textColor: colorScheme.onTertiaryFixed,
              ),
              ColorCard(
                label: 'on\nTertiary\nFixed',
                color: colorScheme.onTertiaryFixed,
                textColor: colorScheme.tertiaryFixed,
              ),
              ColorCard(
                label: 'Tertiary\nFixedDim',
                color: colorScheme.tertiaryFixedDim,
                textColor: colorScheme.onTertiaryFixedVariant,
              ),
              ColorCard(
                label: 'on\nTertiary\nFixedVariant',
                color: colorScheme.onTertiaryFixedVariant,
                textColor: colorScheme.tertiaryFixedDim,
              ),
              ColorCard(
                label: 'Error',
                color: colorScheme.error,
                textColor: colorScheme.onError,
              ),
              ColorCard(
                label: 'on\nError',
                color: colorScheme.onError,
                textColor: colorScheme.error,
              ),
              ColorCard(
                label: 'Error\nContainer',
                color: colorScheme.errorContainer,
                textColor: colorScheme.onErrorContainer,
              ),
              ColorCard(
                label: 'on\nError\nContainer',
                color: colorScheme.onErrorContainer,
                textColor: colorScheme.errorContainer,
              ),
              ColorCard(
                label: 'Surface$surfaceTooHigh',
                color: colorScheme.surface,
                textColor: colorScheme.onSurface,
              ),
              ColorCard(
                label: 'on\nSurface',
                color: colorScheme.onSurface,
                textColor: colorScheme.surface,
              ),
              ColorCard(
                label: 'Surface\nDim',
                color: colorScheme.surfaceDim,
                textColor: colorScheme.onSurface,
              ),
              ColorCard(
                label: 'Surface\nBright',
                color: colorScheme.surfaceBright,
                textColor: colorScheme.onSurface,
              ),
              ColorCard(
                label: 'Surface\nContainer\nLowest',
                color: colorScheme.surfaceContainerLowest,
                textColor: colorScheme.onSurface,
              ),
              ColorCard(
                label: 'Surface\nContainer\nLow',
                color: colorScheme.surfaceContainerLow,
                textColor: colorScheme.onSurface,
              ),
              ColorCard(
                label: 'Surface\nContainer',
                color: colorScheme.surfaceContainer,
                textColor: colorScheme.onSurface,
              ),
              ColorCard(
                label: 'Surface\nContainer\nHigh',
                color: colorScheme.surfaceContainerHigh,
                textColor: colorScheme.onSurface,
              ),
              ColorCard(
                label: 'Surface\nContainer\nHighest',
                color: colorScheme.surfaceContainerHighest,
                textColor: colorScheme.onSurface,
              ),
              ColorCard(
                label: 'onSurface\nVariant',
                color: colorScheme.onSurfaceVariant,
                textColor: colorScheme.surface,
              ),
              ColorCard(
                label: 'Outline',
                color: colorScheme.outline,
                textColor: _onColor(colorScheme.outline, background),
              ),
              ColorCard(
                label: 'Outline\nVariant',
                color: colorScheme.outlineVariant,
                textColor: _onColor(colorScheme.outlineVariant, background),
              ),
              ColorCard(
                label: 'Shadow',
                color: colorScheme.shadow,
                textColor: _onColor(colorScheme.shadow, background),
              ),
              ColorCard(
                label: 'Scrim',
                color: colorScheme.scrim,
                textColor: _onColor(colorScheme.shadow, background),
              ),
              ColorCard(
                label: 'Inverse\nSurface',
                color: colorScheme.inverseSurface,
                textColor: colorScheme.onInverseSurface,
              ),
              ColorCard(
                label: 'onInverse\nSurface',
                color: colorScheme.onInverseSurface,
                textColor: colorScheme.inverseSurface,
              ),
              ColorCard(
                label: 'Inverse\nPrimary',
                color: colorScheme.inversePrimary,
                textColor: colorScheme.inverseSurface,
              ),
              ColorCard(
                label: 'Surface\nTint',
                color: colorScheme.surfaceTint,
                textColor: colorScheme.onPrimary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
