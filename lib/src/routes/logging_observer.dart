import 'package:flutter/material.dart';
import 'package:wonder/src/logger.dart';

class LoggingObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    logger.d(
        '[root.didPush] previous: {${previousRoute?.settings.name ?? previousRoute?.settings}}, new: ${route.settings.name ?? route.settings}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    logger.d(
        '[root.didPop] previous: {${previousRoute?.settings.name ?? previousRoute?.settings}}, popped: ${route.settings.name ?? route.settings}');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    logger.d(
        '[root.didReplace] old: {${oldRoute?.settings.name ?? oldRoute?.settings}}, new: ${newRoute?.settings.name ?? newRoute?.settings}}');
  }
}
