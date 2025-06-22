import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/debug_utils.dart';
import '../debug/error_view.dart';

typedef GetProviderOverrides = Future<List<Override>> Function();

class DeferredProviderScope extends StatelessWidget {
  final Future<List<Override>> Function() loadOverrides;
  final Widget child;

  const DeferredProviderScope({
    super.key,
    required this.loadOverrides,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Override>>(
      future: wrapWithErrorLogging(
        function: loadOverrides,
        errorMessage: 'Error while loading provider overrides',
      )(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return ErrorView(snapshot.error!, snapshot.stackTrace);
        }

        if (!snapshot.hasData) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        return ProviderScope(
          overrides: snapshot.data!,
          child: child,
        );
      },
    );
  }
}
