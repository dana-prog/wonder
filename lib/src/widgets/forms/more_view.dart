import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../resources/labels.dart';
import '../../routes/locations.dart';

final items = [
  {
    'name': 'theme',
    'title': Titles.theme,
    'icon': Icons.palette,
    'route': Locations.themeSettings,
  },
  {
    'name': 'debug',
    'title': Titles.debug,
    'icon': Icons.bug_report,
    'route': Locations.debug,
  },
];

class MoreView extends StatelessWidget {
  const MoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (_, __) => const Divider(height: 0),
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          leading: Icon(item['icon'] as IconData),
          title: Text(item['title'] as String),
          onTap: () {
            context.push(item['route'] as String); // navigate to target
          },
        );
      },
    );
  }
}
