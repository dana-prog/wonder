import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_theme.dart';
import '../routes/routes.dart';

const _locale = Locale('en');

class Root extends ConsumerStatefulWidget {
  const Root();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RootState();
}

class _RootState extends ConsumerState<Root> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // theme: ref.watch(darkThemeProvider),
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
