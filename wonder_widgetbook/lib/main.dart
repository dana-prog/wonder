import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
// import 'package:wonder/mock/mock_provider_overrides.dart';
import 'package:wonder/mock/mock_token.dart';
import 'package:wonder/run.dart';
import 'package:wonder/src/theme/app_theme.dart';
import 'package:wonder_widgetbook/src/folders.dart';

import './src/logger.dart';

@App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    logger.d('[WidgetbookApp.build]');

    return Widgetbook.material(
      initialRoute: '?path=[platform]/wixfileurlimage',
      // initialRoute: '?path=client/authentication/all',
      // initialRoute: '?path=facility/facilitydetailspage/new',
      // initialRoute: '?path=facility/facilitycard/default',
      // initialRoute: '?path=facility/editors/facilitystatusdropdown/status',
      // initialRoute: '?path=user/all/all',
      // initialRoute: '?path=debug/unboundedwidth/not_working',
      directories: folders,
      addons: [
        _RouteLoggerAddon(),
        MaterialThemeAddon(themes: [
          WidgetbookTheme(name: 'Light', data: AppTheme.light),
          WidgetbookTheme(name: 'Dark', data: AppTheme.dark),
        ])
      ],
      appBuilder: (context, child) => Container(
          constraints: BoxConstraints.expand(),
          padding: EdgeInsets.all(20),
          alignment: Alignment.topCenter,
          child: child),
    );
  }
}

class _RouteLoggerAddon extends WidgetbookAddon<String> {
  _RouteLoggerAddon() : super(name: 'Route Logger');

  @override
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    String setting,
  ) {
    // Log the path on each use case build
    final path = WidgetbookState.of(context).path;
    logger.d('📍 Widgetbook route: $path');
    return child;
  }

  @override
  List<Field<String>> get fields => [];

  @override
  String valueFromQueryGroup(Map<String, String> group) => '';
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final providerOverridesFactory = getWixProviderOverridesFactory(
    authRedirectUrl: '',
    token: mockToken,
  );
  final overrides = await providerOverridesFactory();

  runApp(
    ProviderScope(
      overrides: overrides,
      child: const WidgetbookApp(),
    ),
  );
}
