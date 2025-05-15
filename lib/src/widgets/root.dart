import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../routes/routes.dart';

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
      // localizationsDelegates: const [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      supportedLocales: [_locale],
    );
  }
}
