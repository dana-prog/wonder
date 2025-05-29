import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wonder/src/widgets/item/item_form.dart';

import '../logger.dart';
import '../widgets/forms/debug_view.dart';
import '../widgets/forms/main_view.dart';
import '../widgets/forms/single_view_form.dart';
import 'locations.dart';

final router = GoRouter(
  initialLocation: Locations.initial,
  routes: [
    // tickets
    GoRoute(
        path: Locations.tickets,
        builder: (context, state) {
          logger.d('[router.tickets]');
          return MainView(ticketsPageName);
        }),
    // facilities
    GoRoute(
        path: Locations.facilities,
        builder: (context, state) {
          logger.d('[router.facilities]');
          return MainView(facilitiesPageName);
        }),
    // item
    GoRoute(
      path: Locations.item,
      builder: (context, state) {
        logger.d('[router.item]');
        final itemType = state.pathParameters['itemType']!;
        final id = state.pathParameters['itemId']!;

        if (itemType != 'facility') {
          final error = 'invalid item type: $itemType';
          logger.e('[router.item] $error');
          return const Text('Invalid item type');
        }

        // TODO: check this as the initial route
        // TODO: try replacing the SingleViewScaffold with Material
        return SingleViewScaffold(
          child: ItemFormConsumer(itemType: itemType, id: id),
        );
      },
    ),
    // debug
    GoRoute(
      path: Locations.debug,
      builder: (context, state) {
        return SingleViewScaffold(child: DebugView());
      },
    ),
    // more
    GoRoute(
      path: Locations.more,
      builder: (context, state) {
        return MainView(morePageName);
      },
    ),
  ],
  onException: (exception, state, router) {
    logger.e(
      '[router] exception: $exception, state: $state',
    );
  },
);
