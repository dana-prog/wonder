import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wonder/src/routes/logging_observer.dart';
import 'package:wonder/src/widgets/item/item_form.dart';
import 'package:wonder/src/widgets/media/image_page.dart';

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
        logger.d('[router.item]: ${state.path}');
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
    // image
    GoRoute(
      path: Locations.image,
      builder: (context, state) {
        final path = state.pathParameters['path']!;
        return ImagePage(path: path);
      },
    ),
  ],
  observers: [LoggingObserver()],
  onException: (exception, state, router) {
    logger.e(
      '[router] exception: $exception, state: $state',
    );
  },
);
