import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wonder/src/widgets/forms/debug_view.dart';
import 'package:wonder/src/widgets/forms/main_view.dart';
import 'package:wonder/src/widgets/forms/single_view_form.dart';
import 'package:wonder/src/widgets/item/facility_form.dart';

import '../logger.dart';
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
        final type = state.pathParameters['itemType']!;
        final id = state.pathParameters['itemId']!;

        if (type != 'facility') {
          final error = 'invalid item type: $type';
          logger.e('[router.item] $error');
          return const Text('Invalid item type');
        }

        return SingleViewScaffold(
          // TODO: [P0] remove hard coded
          viewBuilder: (BuildContext context) => FacilityFormConsumer(id),
        );
      },
    ),
    // debug
    GoRoute(
      path: Locations.debug,
      builder: (context, state) {
        return SingleViewScaffold(
          // TODO: [P0] remove hard coded
          viewBuilder: (BuildContext context) => DebugView(),
        );
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
