import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wonder/src/logger.dart';
import 'package:wonder/src/widgets/forms/more_view.dart';

import '../../resources/labels.dart';
import '../../routes/locations.dart';
import '../items/facility/facilities_main_view.dart';
import '../items/ticket/ticket_list.dart';

class _Page {
  final String name;
  final String navigationItemLabel;
  final IconData icon;
  final WidgetBuilder bodyBuilder;
  final PreferredSizeWidget? titleWidget;
  final FloatingActionButton Function(BuildContext)? floatingActionButtonBuilder;

  const _Page({
    required this.name,
    required this.navigationItemLabel,
    required this.icon,
    required this.bodyBuilder,
    this.titleWidget,
    this.floatingActionButtonBuilder,
  });
}

const String ticketsPageName = 'tickets';
const String facilitiesPageName = 'facilities';
const String morePageName = 'more';

final _pages = [
  _Page(
    name: ticketsPageName,
    navigationItemLabel: ItemsLabels.getPluralLabel('ticket'),
    icon: Icons.confirmation_num,
    bodyBuilder: (BuildContext _) => TicketList(),
  ),
  _Page(
    name: facilitiesPageName,
    navigationItemLabel: ItemsLabels.getPluralLabel('facility'),
    icon: Icons.house,
    bodyBuilder: (BuildContext context) => FacilitiesMainView(),
    floatingActionButtonBuilder: (BuildContext context) => FloatingActionButton(
      onPressed: () => context.push(Locations.newItem.replaceFirst(':itemType', 'facility')),
      child: const Icon(Icons.add),
    ),
  ),
  _Page(
    name: morePageName,
    navigationItemLabel: Titles.more,
    titleWidget: AppBar(title: Text(Titles.more), automaticallyImplyLeading: false),
    icon: Icons.more,
    bodyBuilder: (BuildContext _) => MoreView(),
  ),
];

class MainView extends StatelessWidget {
  final String selectedPageName;

  const MainView(this.selectedPageName, {super.key});

  @override
  Widget build(BuildContext context) {
    logger.t('[MainView.build] selectedPageName: ${_selectedPage.name}');

    return Scaffold(
      appBar: _selectedPage.titleWidget ??
          AppBar(
            title: Text(_selectedPage.navigationItemLabel),
            automaticallyImplyLeading: false,
          ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: _selectedPage.bodyBuilder(context),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: (index) {
          final pageName = _pages[index].name;
          logger.t('[MainForm.onTap] tabIndex: $index, tabName: $pageName');
          context.go('/$pageName');
        },
        items: _pages
            .map(
              (page) => BottomNavigationBarItem(
                icon: Icon(page.icon),
                label: page.navigationItemLabel,
              ),
            )
            .toList(),
      ),
      floatingActionButton: _selectedPage.floatingActionButtonBuilder?.call(context),
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
