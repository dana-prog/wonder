import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'run.dart';
import 'src/client/wix/wix_rest_client.dart';
import 'src/data/list_value_item.dart';
import 'src/data/user_item.dart';
import 'src/providers/client_provider.dart';
import 'src/providers/lists_of_values_provider.dart';
import 'src/providers/users_provider.dart';

void main() async {
  run(_getProviderOverrides);
}

Future<List<Override>> _getProviderOverrides() async {
  final client = await WixRestClient.create();

  final values = await client.fetchItems<ListValueItem>(itemType: 'listValue');
  final users = await client.fetchItems<UserItem>(itemType: 'user');

  return [
    clientProvider.overrideWithValue(client),
    listsValuesProvider.overrideWithValue(ListsValuesCache(values)),
    usersProvider.overrideWithValue(UsersCache(users)),
  ];
}
