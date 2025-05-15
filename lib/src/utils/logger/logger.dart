import 'package:logger/logger.dart' as l;

import 'log_filter.dart';
import 'log_utils.dart';
import 'logger_types.dart';

// TODO: use Filter and Condition classes
enum FilterType { excludePrefixes, includePrefixes }

class Logger extends l.Logger {
  Logger({
    super.level,
    super.output,
    super.printer,
    FilterType filterType = FilterType.excludePrefixes,
    List<String> domains = const [],
  }) : super(filter: AppLogFilter(filterType, domains));

  Future<T> wrapWithLog<T>(
    String message,
    Future<T> Function() callback, {
    String Function(T)? resultLogger,
    Level logLevel = Level.debug,
  }) async {
    T result;
    final stopwatch = Stopwatch();
    stopwatch.start();

    final parts = getMessageParts(message);
    final prefix = parts.item1;
    final operation = parts.item2;

    try {
      log(logLevel, '[$prefix] starting to $operation');
      result = await callback();
      String? resultString = resultLogger != null ? ' result: {${resultLogger(result)}}' : null;

      log(
        logLevel,
        [
          '[$prefix] finished to $operation',
          resultString,
          'elapsed time = ${stopwatch.elapsedMilliseconds}ms',
        ].where((i) => i != null).join(','),
      );
    } catch (error, stackTrace) {
      e(
        '[$prefix] error while $operation',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }

    return result;
  }
}
