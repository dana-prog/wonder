import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wonder/src/logger.dart';
import 'package:wonder/src/widgets/forms/more_view.dart';
import 'package:wonder/src/widgets/item/item_list.dart';

import '../../data/facility_item.dart';
import '../../resources/labels.dart';
import '../facility/facility_card.dart';
import '../notifications/event_messenger.dart';
import '../ticket/ticket_list.dart';

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
const String morePageName = 'more';

class MainView extends StatelessWidget {
  final String selectedPageName;
  final _pages = [
    _Page(
      name: ticketsPageName,
      label: Titles.tickets,
      icon: Icons.confirmation_num,
      widget: TicketList(),
    ),
    _Page(
      name: facilitiesPageName,
      label: Titles.facilities,
      icon: Icons.house,
      widget: ItemList(
          itemType: 'facility',
          itemBuilder: (context, item) => FacilityCard(
                item: item as FacilityItem,
              )),
    ),
    _Page(
      name: morePageName,
      label: Titles.more,
      icon: Icons.more,
      widget: MoreView(),
    ),
  ];

  MainView(this.selectedPageName, {super.key});

  @override
  Widget build(BuildContext context) {
    logger.d('[MainView.build] selectedPageName: ${_selectedPage.name}');

    return Scaffold(
      appBar: AppBar(title: Text(_selectedPage.label)),
      body: EventMessenger(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: _selectedPage.widget,
        ),
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
