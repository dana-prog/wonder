import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/client/wix_client.dart';
import 'src/data/list_value_item.dart';
import 'src/data/user_item.dart';
import 'src/logger.dart';
import 'src/providers/lists_of_values_provider.dart';
import 'src/providers/users_provider.dart';
import 'src/widgets/root.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: consider displaying a LoadingScreen while fetching initial data
  // runApp(const ProviderScope(child: LoadingScreen()));

  final overrides = await _getProviderOverrides();
  logger.d('[main] Provider overrides fetched');

  runApp(ProviderScope(
    overrides: overrides,
    child: const Root(),
  ));
}

Future<List<Override>> _getProviderOverrides() async {
  final wixClient = WixClient();

  final values = await wixClient.fetchItems<ListValueItem>(itemType: 'listValue');
  final users = await wixClient.fetchItems<UserItem>(itemType: 'user');

  return [
    listsValuesProvider.overrideWithValue(ListsValuesCache(values)),
    usersProvider.overrideWithValue(UsersCache(users)),
  ];
}
