import 'package:flutter/material.dart';

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
      showPerformanceOverlay: true,
    );
  }
}
