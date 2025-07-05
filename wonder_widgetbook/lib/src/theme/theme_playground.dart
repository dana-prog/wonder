import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
import 'package:widgetbook/widgetbook.dart';

import 'color_scheme_colors.dart';
import 'material_widgets_colors.dart';
import 'theme_data_colors.dart';

class _Page {
  final String name;
  final IconData icon;
  final WidgetBuilder bodyBuilder;

  const _Page({
    required this.name,
    required this.icon,
    required this.bodyBuilder,
  });

  String get label => name.titleCase;
}

final _pages = [
  _Page(
      name: 'colors',
      icon: Icons.color_lens,
      bodyBuilder: (_) => ColorSchemeColors(showTitle: false)),
  _Page(
      name: 'theme',
      icon: Icons.format_paint,
      bodyBuilder: (_) => ThemeDataColors(showTitle: false)),
  _Page(name: 'widgets', icon: Icons.widgets, bodyBuilder: (_) => MaterialWidgetsColors()),
];

// TODO: move to test project
class ThemePlayground extends StatefulWidget {
  const ThemePlayground({super.key});

  @override
  State<ThemePlayground> createState() => _ThemePlaygroundState();
}

class _ThemePlaygroundState extends State<ThemePlayground> {
  int _selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theme Playground - ${_pages[_selectedPageIndex].label}'),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: _pages[_selectedPageIndex].bodyBuilder(context),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: (index) {
          setState(() {
            _selectedPageIndex = index;
          });
        },
        items: _pages
            .map(
              (page) => BottomNavigationBarItem(
                label: page.label,
                icon: Icon(page.icon),
              ),
            )
            .toList(),
      ),
    );
  }
}

final themePlayground = WidgetbookLeafComponent(
  name: 'Theme Playuground',
  useCase: WidgetbookUseCase(
    name: 'Theme Playuground',
    builder: (_) => const ThemePlayground(),
  ),
);
