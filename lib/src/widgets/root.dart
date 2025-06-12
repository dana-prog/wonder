import 'package:flutter/material.dart';
import 'package:wonder/src/widgets/notifications/event_messenger.dart';

import '../routes/routes.dart';
import '../theme/app_theme.dart';

const _locale = Locale('en');

class Root extends StatelessWidget {
  const Root();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: router,
      locale: _locale,
      supportedLocales: [_locale],
      builder: (context, child) {
        return Overlay(
          initialEntries: [
            OverlayEntry(
              builder: (context) =>
                  child != null ? EventMessenger(child: child) : SizedBox.shrink(),
            ),
          ],
        );
      },
      // showPerformanceOverlay: true,
    );
  }
}
