import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wonder/src/data/item.dart';

import 'run.dart';
import 'src/client/wix/wix_client.dart';
import 'src/data/list_value_item.dart';
import 'src/data/user_item.dart';
import 'src/providers/client_provider.dart';
import 'src/providers/lists_values_provider.dart';
import 'src/providers/users_provider.dart';

void main() async {
  run(_getProviderOverrides);
}

Future<List<Override>> _getProviderOverrides() async {
  final client = await WixClient.create(authRedirectUrl: 'wonderapp://authorization');

  final lists = await client.fetchStaticLists();

  return [
    clientProvider.overrideWithValue(client),
    listsValuesProvider.overrideWithValue(
      ListsValuesCache(
        List.castFrom<Item, ListValueItem>(lists['listValue']!),
      ),
    ),
    usersProvider.overrideWithValue(
      UsersCache(List.castFrom<Item, UserItem>(lists['user']!)),
    ),
  ];
}
