import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wonder/src/data/item.dart' show Item;

import 'src/client/token.dart';
import 'src/client/wix/wix_authentication.dart';
import 'src/client/wix/wix_file_storage.dart';
import 'src/client/wix/wix_items_client.dart';
import 'src/data/list_value_item.dart';
import 'src/data/user_item.dart';
import 'src/logger.dart';
import 'src/providers/client_provider.dart';
import 'src/providers/file_provider.dart';
import 'src/providers/lists_values_provider.dart';
import 'src/providers/users_provider.dart';
import 'src/widgets/async/deferred_provider_scope.dart';
import 'src/widgets/root.dart';

void run(Future<List<Override>> Function() loadProviderOverrides) async {
  logger.t('[run] Application started');
  runZonedGuarded(() async {
    debugProfileBuildsEnabled = true;

    // TODO: how to use FlutterError.onError, ErrorWidget.builder
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details); // keep default behavior
      logger.e('Flutter error', error: details.exception, stackTrace: details.stack);
    };

    ErrorWidget.builder = (FlutterErrorDetails details) {
      return Material(
        child: Center(
          child: Column(
            children: [
              Text('Something went wrong. Please contact the admin.'),
            ],
          ),
        ),
      );
    };

    WidgetsFlutterBinding.ensureInitialized();

    // TODO: consider displaying a LoadingScreen while fetching initial data
    // runApp(const ProviderScope(child: LoadingScreen()));

    runApp(
      DeferredProviderScope(
        loadOverrides: loadProviderOverrides,
        child: const Root(),
      ),
    );
  }, (error, stackTrace) {
    logger.e('Error in runZonedGuarded', error: error, stackTrace: stackTrace);
  });
}

Future<List<Override>> Function() getWixProviderOverridesFactory({
  required String authRedirectUrl,
  Token? token,
}) {
  return () async {
    final authentication = await WixAuthentication.create(
      authRedirectUrl: authRedirectUrl,
      token: token,
    );
    final client = WixItemsClient(authentication: authentication);
    final fileStorage = WixFileStorage(authentication: client.authentication);

    final lists = await client.fetchStaticLists();
    final listsValues = List.castFrom<Item, ListValueItem>(lists['listValue']!);
    final users = List.castFrom<Item, UserItem>(lists['user']!);

    return [
      clientProvider.overrideWithValue(client),
      fileStoragePluginProvider.overrideWithValue(fileStorage),
      // listsValuesProvider and usersProvider should be initialized automatically so that other apps (like wonder_widgetbook) should not ave to explicitly override them (since the data will be automatically fetched from the provided client).
      listsValuesProvider.overrideWithValue(ListsValuesCache(listsValues)),
      usersProvider.overrideWithValue(UsersCache(users)),
    ];
  };
}
