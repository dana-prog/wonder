import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wonder/mock/mock_data.dart';
import 'package:wonder/src/providers/client_provider.dart';
import 'package:wonder/src/providers/file_provider.dart';
import 'package:wonder/src/providers/lists_values_provider.dart';
import 'package:wonder/src/providers/users_provider.dart';

import 'mock_client.dart';
import 'mock_file_storage.dart';

List<Override> getMockProviderOverrides() {
  return [
    clientProvider.overrideWithValue(MockClient()),
    fileStoragePluginProvider.overrideWithValue(MockFileStorage()),
    listsValuesProvider.overrideWithValue(ListsValuesCache(MockData.listValues)),
    usersProvider.overrideWithValue(UsersCache(MockData.users)),
  ];
}
