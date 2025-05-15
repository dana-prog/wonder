import 'dart:developer' as dev;

import 'logger_types.dart';

class DartLogOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    RegExp regExp = RegExp(r'\[(.*?)\]\s*(.*)');
    Match? match = regExp.firstMatch(event.origin.message.toString());

    dev.log(
      match?.group(2).toString() ?? 'n/a',
      name: match?.group(1) ?? 'n/a',
      level: _mapLogLevel(event.level),
      time: event.origin.time,
      error: event.origin.error,
      stackTrace: event.origin.stackTrace,
    );
  }

  int _mapLogLevel(Level level) {
    switch (level) {
      case Level.debug:
        return 0; // Info
      case Level.info:
        return 500; // Warning
      case Level.warning:
        return 800; // Severe
      case Level.error:
        return 900; // Critical
      case Level.fatal:
        return 1000; // Critical
      default:
        return 0;
    }
  }
}
