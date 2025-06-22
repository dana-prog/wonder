import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/logger.dart';
import 'src/widgets/async/deferred_provider_scope.dart';
import 'src/widgets/root.dart';

void run(Future<List<Override>> Function() loadProviderOverrides) async {
  logger.t('[run] Application started');
  runZonedGuarded(() async {
    debugProfileBuildsEnabled = true;

    // TODO: how to use FlutterError.onError, ErrorWidget.builder
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details); // keep default behavior
      logger.e('Flutter error', error: details.exception, stackTrace: details.stack);
    };

    ErrorWidget.builder = (FlutterErrorDetails details) {
      return Material(
        child: Center(
          child: Column(
            children: [
              Text('Something went wrong. Please contact the admin.'),
            ],
          ),
        ),
      );
    };

    WidgetsFlutterBinding.ensureInitialized();

    // TODO: consider displaying a LoadingScreen while fetching initial data
    // runApp(const ProviderScope(child: LoadingScreen()));

    runApp(
      DeferredProviderScope(
        loadOverrides: loadProviderOverrides,
        child: const Root(),
      ),
    );
  }, (error, stackTrace) {
    logger.e('Error in runZonedGuarded', error: error, stackTrace: stackTrace);
  });
}
