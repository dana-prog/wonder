import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wonder/src/widgets/forms/main_form.dart';
import 'package:wonder/src/widgets/forms/single_view_form.dart';
import 'package:wonder/src/widgets/item/facility_form.dart';

import '../data/data_item.dart';
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
          return MainForm(MainForm.ticketsTabName);
        }),
    // facilities
    GoRoute(
        path: Locations.facilities,
        builder: (context, state) {
          logger.d('[router.facilities]');
          return MainForm(MainForm.facilitiesTabName);
        }),
    // item
    GoRoute(
      path: Locations.item,
      builder: (context, state) {
        final type = state.pathParameters['itemType']!;
        final id = state.pathParameters['itemId']!;

        if (type != DataItemType.facility.name) {
          logger.e('[router.item] invalid item type: $type');
          return const Text('Invalid item type');
        }

        return SingleViewScaffold(
          // TODO: P0 remove hard coded
          title: 'Edit Villa',
          viewBuilder: (BuildContext context) => FacilityFormConsumer(id),
        );
      },
    )
  ],
  onException: (exception, state, router) {
    logger.e(
      '[router] exception: $exception, state: $state',
    );
  },
);
