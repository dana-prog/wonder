import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/client_provider.dart';
import '../../router/routes_names.dart';

class MoreItem {
  final String name;
  final String title;
  final IconData icon;
  final String? route;
  final Function(BuildContext, WidgetRef)? onTap;

  MoreItem({
    required this.name,
    required this.title,
    required this.icon,
    this.route,
    this.onTap,
  });
}

final _moreItems = [
  MoreItem(
    name: 'themePlayground',
    title: 'Theme Playground',
    icon: Icons.palette,
    route: '${RouteNames.more}/${MoreSubLocations.themePlayground}',
  ),
  MoreItem(
    name: 'printMyMember',
    title: 'Print My Member',
    icon: Icons.person,
    onTap: (BuildContext context, WidgetRef ref) {
      final client = ref.watch(clientProvider);
      client.itemsClient.printMyMember();
    },
  ),
  MoreItem(
    name: 'logout',
    title: 'Logout',
    icon: Icons.logout,
    onTap: (BuildContext context, WidgetRef ref) async {
      final client = ref.watch(clientProvider);
      await client.itemsClient.logout();
    },
  ),
];

class MoreView extends ConsumerWidget {
  const MoreView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      itemCount: _moreItems.length,
      separatorBuilder: (_, __) => const Divider(height: 0),
      itemBuilder: (context, index) {
        final item = _moreItems[index];
        return ListTile(
          leading: Icon(item.icon),
          title: Text(item.title),
          onTap: () {
            if (item.onTap != null) {
              item.onTap!(context, ref);
              return;
            }

            if (item.route != null) {
              context.push(item.route!);
              return;
            }
          },
        );
      },
    );
  }
}
