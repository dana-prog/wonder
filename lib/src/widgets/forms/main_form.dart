import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wonder/src/logger.dart';

import '../../resources/labels.dart';
import '../lists/facility_list.dart';
import '../lists/ticket_list.dart';

class TabData {
  final String name;
  final String label;
  final IconData icon;
  final Widget Function() widget;

  const TabData({
    required this.name,
    required this.label,
    required this.icon,
    required this.widget,
  });
}

class MainForm extends ConsumerWidget {
  static const String ticketsTabName = 'tickets';
  static const String facilitiesTabName = 'facilities';

  static const tabs = [
    TabData(name: ticketsTabName, label: Labels.ticketsTitle, icon: Icons.bug_report, widget: TicketList.new),
    TabData(name: facilitiesTabName, label: Labels.facilitiesTitle, icon: Icons.house, widget: FacilityList.new),
  ];

  final String selectedTabName;

  const MainForm(this.selectedTabName, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    logger.d('[MainForm.build] selectedTabName: $selectedTabName');

    return Scaffold(
      body: selectedTab.widget(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedTabIndex,
        onTap: (tabIndex) {
          final tabName = tabs[tabIndex].name;
          logger.d('[MainForm.onTap] tabIndex: $tabIndex, tabName: $tabName');
          context.go('/$tabName');
        },
        items: tabs
            .map(
              (tab) => BottomNavigationBarItem(
                icon: Icon(tab.icon),
                label: tab.label,
              ),
            )
            .toList(),
      ),
    );
  }

  int get selectedTabIndex => tabs.indexWhere((tab) => tab.name == selectedTabName);

  TabData get selectedTab => tabs[selectedTabIndex];
}
