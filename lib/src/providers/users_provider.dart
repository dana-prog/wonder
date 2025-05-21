import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wonder/src/data/data_item.dart';
import 'package:wonder/src/providers/wix_client_provider.dart';

import '../data/user_item.dart';
import '../wix/sdk/wix_client.dart';

final _allUsersProvider = FutureProvider<_UserList>((
  ref,
) async {
  if (_userList == null) {
    final wixClient = ref.watch(wixClientProvider);
    final users = await wixClient.fetchItems(
      dataCollectionId: DataItemType.user.pluralName,
      itemConstructor: UserItem.fromDataCollection,
      sortBy: [
        ('firstName', SortOrder.ascending),
        ('nickname', SortOrder.ascending),
        ('lastName', SortOrder.ascending),
      ],
    );

    _userList = _UserList(users);
  }

  return _userList!;
});

final usersProvider = FutureProvider<List<UserItem>>((
  ref,
) async {
  final userList = await ref.watch(_allUsersProvider.future);
  return userList.users;
});

final userProvider = FutureProvider.family<UserItem, String>((
  ref,
  id,
) async {
  final userList = await ref.watch(_allUsersProvider.future);
  return userList.getUserById(id);
});

_UserList? _userList;

class _UserList {
  late List<UserItem> _users;
  late Map<String, UserItem> _usersById;

  _UserList(List<UserItem> users) {
    _users = users;
    _usersById = {};
    for (var item in users) {
      _usersById[item.id] = item;
    }
  }

  UserItem getUserById(String id) {
    final item = _usersById[id];
    if (item == null) {
      throw Exception('User with id $id not found');
    }
    return item;
  }

  List<UserItem> get users => _users;
}
