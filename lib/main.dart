import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'run.dart';
import 'src/client/wix_client.dart';
import 'src/data/list_value_item.dart';
import 'src/data/user_item.dart';
import 'src/providers/lists_of_values_provider.dart';
import 'src/providers/users_provider.dart';

void main() async {
  run(_getProviderOverrides);
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
