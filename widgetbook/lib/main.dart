import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:wonder/mock/mock_client.dart';
import 'package:wonder/mock/mock_data.dart';
import 'package:wonder/src/providers/client_provider.dart';
import 'package:wonder/src/providers/lists_of_values_provider.dart';
import 'package:wonder/src/providers/users_provider.dart';
import 'package:wonder/src/theme/app_theme.dart';

import './src/logger.dart';
import 'main.directories.g.dart';

void main() async {
  final overrides = _getProviderOverrides();

  runApp(
    ProviderScope(
      overrides: overrides,
      child: const WidgetbookApp(),
    ),
  );
}

@App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    logger.d('[WidgetbookApp.build]');

    return Widgetbook.material(
      // initialRoute: '?path=facility/facilitydetailspage/view',
      initialRoute: '[Facility]/FacilityDetailsPage/Edit',
      directories: directories,
      addons: [
        MaterialThemeAddon(themes: [
          WidgetbookTheme(name: 'Light', data: AppTheme.light),
          WidgetbookTheme(name: 'Dark', data: AppTheme.dark),
        ])
      ],
      appBuilder: (context, child) => Container(
          padding: EdgeInsets.all(20),
          alignment: Alignment.topCenter,
          child: child), // or any wrapper
    );
  }
}

List<Override> _getProviderOverrides() {
  return [
    listsValuesProvider.overrideWithValue(ListsValuesCache(MockData.listValues)),
    usersProvider.overrideWithValue(UsersCache(MockData.users)),
    clientProvider.overrideWithValue(MockClient()),
  ];
}
