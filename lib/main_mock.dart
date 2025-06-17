import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wonder/run.dart';

import 'mock/mock_client.dart';
import 'src/data/list_value_item.dart';
import 'src/data/user_item.dart';
import 'src/providers/client_provider.dart';
import 'src/providers/lists_of_values_provider.dart';
import 'src/providers/users_provider.dart';

void main() async {
  run(_getMockProviderOverrides);
}

Future<List<Override>> _getMockProviderOverrides() async {
  final client = MockClient();

  return [
    clientProvider.overrideWithValue(client),
    listsValuesProvider.overrideWithValue(
      ListsValuesCache(client.initialItems.whereType<ListValueItem>().toList()),
    ),
    usersProvider.overrideWithValue(
      UsersCache(client.initialItems.whereType<UserItem>().toList()),
    ),
  ];
}
