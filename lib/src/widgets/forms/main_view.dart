import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wonder/src/logger.dart';
import 'package:wonder/src/widgets/forms/debug_view.dart';

import '../../resources/labels.dart';
import '../lists/facility_list.dart';
import '../lists/ticket_list.dart';

class _Page {
  final String name;
  final String label;
  final IconData icon;
  final Widget widget;

  const _Page({
    required this.name,
    required this.label,
    required this.icon,
    required this.widget,
  });
}

const String ticketsPageName = 'tickets';
const String facilitiesPageName = 'facilities';
const String debugPageName = 'debug';

class MainView extends StatelessWidget {
  final String selectedPageName;
  final _pages = [
    _Page(
      name: ticketsPageName,
      label: Labels.ticketsTitle,
      icon: Icons.confirmation_num,
      widget: TicketList(),
    ),
    _Page(
      name: facilitiesPageName,
      label: Labels.facilitiesTitle,
      icon: Icons.house,
      widget: FacilityList(),
    ),
    _Page(
      name: debugPageName,
      label: Labels.debugTitle,
      icon: Icons.bug_report,
      widget: DebugView(),
    ),
  ];

  MainView(this.selectedPageName, {super.key});

  @override
  Widget build(BuildContext context) {
    logger.d('[MainView.build] selectedPageName: ${_selectedPage.name}');

    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedPage.label),
        // leading: Icon(selectedTab.icon),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: _selectedPage.widget,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: (index) {
          final pageName = _pages[index].name;
          logger.d('[MainForm.onTap] tabIndex: $index, tabName: $pageName');
          context.go('/$pageName');
        },
        items: _pages
            .map(
              (page) => BottomNavigationBarItem(
                icon: Icon(page.icon),
                label: page.label,
              ),
            )
            .toList(),
      ),
    );
  }

  int get _selectedPageIndex => _pages.indexWhere(
        (page) => page.name == selectedPageName,
      );

  _Page get _selectedPage => _pages.firstWhere(
        (page) => page.name == selectedPageName,
        orElse: () => _pages.first,
      );
}
