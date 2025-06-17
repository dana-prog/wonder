import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/logger.dart';
import 'src/widgets/root.dart';

typedef GetProviderOverrides = Future<List<Override>> Function();

void run(Future<List<Override>> Function() getProviderOverrides) async {
  logger.t('[run] Application started');
  runZonedGuarded(() async {
    debugProfileBuildsEnabled = true;

    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details); // keep default behavior
      logger.e('Flutter error', error: details.exception, stackTrace: details.stack);
    };

    WidgetsFlutterBinding.ensureInitialized();

    // TODO: consider displaying a LoadingScreen while fetching initial data
    // runApp(const ProviderScope(child: LoadingScreen()));

    final overrides = await getProviderOverrides();
    logger.t('[run] Provider overrides fetched');

    runApp(
      ProviderScope(
        overrides: overrides,
        child: const Root(),
      ),
    );
  }, (error, stackTrace) {
    logger.e('Error in runZonedGuarded', error: error, stackTrace: stackTrace);
  });
}
