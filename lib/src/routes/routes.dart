import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../logger.dart';
import '../widgets/forms/debug/editors_playground.dart';
import '../widgets/forms/debug/theme/theme_view.dart';
import '../widgets/forms/main_view.dart';
import '../widgets/forms/single_view_form.dart';
import '../widgets/items/item_form.dart';
import '../widgets/media/image_page.dart';
import 'locations.dart';
import 'logging_observer.dart';

final router = GoRouter(
  initialLocation: Locations.initial,
  routes: [
    // tickets
    GoRoute(
        path: Locations.tickets,
        builder: (context, state) {
          return MainView(ticketsPageName);
        }),
    // facilities
    GoRoute(
        path: Locations.facilities,
        builder: (context, state) {
          return MainView(facilitiesPageName);
        }),
    // item
    GoRoute(
      path: Locations.editItem,
      builder: (context, state) {
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
    // more
    GoRoute(
        path: Locations.more,
        builder: (context, state) {
          return MainView(morePageName);
        },
        routes: [
          // editors playground
          GoRoute(
              path: MoreSubLocations.editorsPlayground,
              builder: (context, state) {
                return EditorsPlayground();
              }),
          // theme playground
          GoRoute(
            path: MoreSubLocations.themePlayground,
            builder: (context, state) {
              return ThemePlayground();
            },
          ),
        ]),
    // image
    GoRoute(
      path: Locations.image,
      builder: (context, state) {
        final path = state.pathParameters['path']!;
        return ImagePage(path: path);
      },
    ),
    // new item
    GoRoute(
        path: Locations.newItem,
        builder: (context, state) {
          final itemType = state.pathParameters['itemType']!;
          assert(itemType == 'facility', 'only facility is supported for new items');

          return SingleViewScaffold(
            child: ItemFormConsumer(itemType: itemType, id: null),
          );
        }),
  ],
  observers: [LoggingObserver()],
  onException: (exception, state, router) {
    logger.e(
      '[router] exception: $exception, state: $state',
    );
  },
);
