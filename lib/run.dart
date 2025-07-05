import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wonder/src/client/wix/wix_client.dart';
import 'package:wonder/src/data/item.dart' show Item;

import 'src/client/client.dart';
import 'src/client/token.dart';
import 'src/data/list_value_item.dart';
import 'src/data/user_item.dart';
import 'src/logger.dart';
import 'src/providers/client_provider.dart';
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

typedef ClientCreatedCallback = Future<void> Function(Client client);
typedef UsersLoadedCallback = Future<void> Function(List<UserItem> users);
typedef ListsLoadedCallback = Future<void> Function(List<ListValueItem> listsValues);

Future<List<Override>> Function() loadWixProviderOverridesFactory({
  required String authRedirectUrl,
  Token? token,
  ClientCreatedCallback? onClientCreated,
  UsersLoadedCallback? onUsersLoaded,
  ListsLoadedCallback? onListsLoaded,
}) {
  return () async {
    final client = await WixClient.create(authRedirectUrl: authRedirectUrl, token: token);
    if (onClientCreated != null) await onClientCreated(client);

    return loadProviderOverrides(
      client,
      onUsersLoaded: onUsersLoaded,
      onListsLoaded: onListsLoaded,
    );
  };
}

Future<List<Override>> loadProviderOverrides(Client client, {onUsersLoaded, onListsLoaded}) async {
  final lists = await client.itemsClient.fetchStaticLists();
  final listsValues = List.castFrom<Item, ListValueItem>(lists['listValue']!);
  final users = List.castFrom<Item, UserItem>(lists['user']!);

  if (onUsersLoaded != null) await onUsersLoaded.call(users);
  if (onListsLoaded != null) await onListsLoaded?.call(listsValues);

  return [
    clientProvider.overrideWithValue(client),
    listsValuesProvider.overrideWithValue(ListsValuesCache(listsValues)),
    usersProvider.overrideWithValue(UsersCache(users)),
  ];
}
