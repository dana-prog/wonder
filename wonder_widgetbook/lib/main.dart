import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
// import 'package:wonder/mock/mock_provider_overrides.dart';
import 'package:wonder/mock/wix_mock_token.dart';
import 'package:wonder/run.dart';
import 'package:wonder/src/client/client.dart';
import 'package:wonder/src/data/facility_item.dart';
import 'package:wonder/src/data/list_value_item.dart';
import 'package:wonder/src/data/user_item.dart';
import 'package:wonder/src/theme/app_theme.dart';
import 'package:wonder/src/widgets/async/deferred_provider_scope.dart';
import 'package:wonder_widgetbook/src/folders.dart';

import './src/logger.dart';
import 'src/utils/widgetbook_data.dart';

@App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    logger.d('[WidgetbookApp.build]');

    return Widgetbook.material(
      initialRoute: '?path=platform/media/appimage/appimage',
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
    logger.d('[_RouteLoggerAddon.buildUseCase ] Widgetbook route: $path');
    return child;
  }

  @override
  List<Field<String>> get fields => [];

  @override
  String valueFromQueryGroup(Map<String, String> group) => '';
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // final loadOverrides = getMockProviderOverridesFactory(
  //   onClientCreated: onClientCreated,
  //   onUsersLoaded: onUsersLoaded,
  //   onListsLoaded: onListsLoaded,
  // );
  final loadOverrides = loadWixProviderOverridesFactory(
    // TODO: to enable real login use a real authRedirectUrl (and then we can remove the wixMockToken)
    authRedirectUrl: '',
    // TODO: now that we enable saving the toekn also on web check if we can remove the wixMockToken
    token: wixMockToken,
    onClientCreated: onClientCreated,
    onUsersLoaded: onUsersLoaded,
    onListsLoaded: onListsLoaded,
  );

  runApp(
    DeferredProviderScope(
      loadOverrides: loadOverrides,
      child: const WidgetbookApp(),
    ),
  );
}

Future<void> onClientCreated(Client client) async {
  final files = await client.fileStoragePlugin.listFiles(includeSubfolders: true);
  WidgetbookData.files.addAll(files);
  WidgetbookData.facilities.addAll(
    await client.itemsClient.fetchItems<FacilityItem>(itemType: 'facility'),
  );
}

Future<void> onUsersLoaded(List<UserItem> loadedUsers) async {
  for (final user in loadedUsers) {
    final key = '${user['firstName'].toLowerCase()}.${user['lastName'].toLowerCase()}';
    WidgetbookData.users[key] = user;
  }
}

Future<void> onListsLoaded(List<ListValueItem> loadedListsValues) async {
  for (final listValue in loadedListsValues) {
    WidgetbookData.lists[listValue.type] ??= {};
    WidgetbookData.lists[listValue.type]![listValue.name] = listValue;
  }
}
