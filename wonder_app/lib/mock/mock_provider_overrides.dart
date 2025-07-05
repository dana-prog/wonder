import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wonder/run.dart';

import 'mock_client.dart';

Future<List<Override>> Function() getMockProviderOverridesFactory({
  ClientCreatedCallback? onClientCreated,
  UsersLoadedCallback? onUsersLoaded,
  ListsLoadedCallback? onListsLoaded,
}) {
  return () async {
    final client = MockClient();
    onClientCreated?.call(client);
    return await loadProviderOverrides(
      client,
      onUsersLoaded: onUsersLoaded,
      onListsLoaded: onListsLoaded,
    );
  };
}
