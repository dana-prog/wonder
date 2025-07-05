import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/user_item.dart';

final usersProvider =
    Provider<UsersCache>((ref) => throw Exception('userListProvider state was not set'));

final userListProvider = Provider<List<UserItem>>((ref) {
  final userList = ref.watch(usersProvider);
  return userList.allUsers;
});

// TODO: check caching
final userProvider = Provider.family<UserItem, String>((ref, id) {
  final userList = ref.watch(usersProvider);
  return userList.getUserById(id);
});

class UsersCache {
  late List<UserItem> _users;
  late Map<String, UserItem> _usersById;

  UsersCache(List<UserItem> users) {
    _users = users;
    _usersById = {};
    for (var item in users) {
      assert(item.id.isNotEmpty,
          'UserItem id cannot by empty (cannot add new items without id to the cache)');

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

  List<UserItem> get allUsers => _users;
}
