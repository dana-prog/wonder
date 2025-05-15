import 'package:go_router/go_router.dart';
import 'package:wonder/src/widgets/forms/main_form.dart';

import '../logger.dart';
import 'locations.dart';

final router = GoRouter(
  initialLocation: Locations.initial,
  routes: [
    GoRoute(
        path: Locations.tickets,
        builder: (context, state) {
          logger.d('[router.tickets]');
          return MainForm(MainForm.ticketsTabName);
        }),
    GoRoute(
        path: Locations.facilities,
        builder: (context, state) {
          logger.d('[router.facilities]');
          return MainForm(MainForm.facilitiesTabName);
        }),
  ],
  onException: (exception, state, router) {
    logger.e(
      '[router] exception: $exception, state: $state',
    );
  },
);
