import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wonder/src/data/list_value_item.dart';
import 'package:wonder/src/data/user_item.dart';
import 'package:wonder/src/providers/lists_values_provider.dart';
import 'package:wonder/src/providers/users_provider.dart';

typedef WidgetBuilderWithUser = Widget Function(BuildContext context, UserItem user);

Widget buildWithUser(String email, WidgetBuilderWithUser builder) {
  return ProviderScope(
    // Optionally add overrides here
    child: Consumer(
      builder: (context, ref, _) {
        final usersCache = ref.watch(usersProvider);
        final user = usersCache.allUsers.firstWhere((user) => user['email'] == email);

        return builder(context, user);
      },
    ),
  );
}

typedef WidgetBuilderWithUsers = Widget Function(BuildContext context, List<UserItem> users);

Widget buildWithUsers(WidgetBuilderWithUsers builder) {
  return ProviderScope(
    child: Consumer(
      builder: (context, ref, _) {
        final usersCache = ref.watch(usersProvider);
        final users = usersCache.allUsers;

        return builder(context, users);
      },
    ),
  );
}

typedef WidgetBuilderWithListValue = Widget Function(
  BuildContext context,
  ListValueItem listValueItem,
);

Widget buildWithListValue(
  String listType,
  String valueName,
  WidgetBuilderWithListValue builder,
) {
  return ProviderScope(
    child: Consumer(
      builder: (context, ref, _) {
        final listsValues = ref.watch(listsValuesProvider);
        final listValueItem =
            listsValues.getList(listType).firstWhere((item) => item.name == valueName);

        return builder(context, listValueItem);
      },
    ),
  );
}

typedef WidgetBuilderWithListValues = Widget Function(
    BuildContext context, List<ListValueItem> listValueItems);

Widget buildWithListValues(
  String listType,
  WidgetBuilderWithListValues builder,
) {
  return ProviderScope(
    child: Consumer(
      builder: (context, ref, _) {
        final listsValues = ref.watch(listsValuesProvider);
        final listValueItems = listsValues.getList(listType);

        return builder(context, listValueItems);
      },
    ),
  );
}

typedef WidgetBuilderWithStaticLists = Widget Function(
  BuildContext context,
  ListsValuesCache listsValuesCache,
  UsersCache usersCache,
);

Widget buildWithStaticLists(WidgetBuilderWithStaticLists builder) {
  return ProviderScope(
    child: Consumer(
      builder: (context, ref, _) {
        final listsValuesCache = ref.watch(listsValuesProvider);
        final usersCache = ref.watch(usersProvider);

        return builder(context, listsValuesCache, usersCache);
      },
    ),
  );
}
