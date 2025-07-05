import 'log_utils.dart';
import 'logger.dart';
import 'logger_types.dart';

class AppLogFilter extends DevelopmentFilter {
  AppLogFilter(this.filterType, this.prefixes);

  final FilterType filterType;
  final List<String> prefixes;

  @override
  bool shouldLog(LogEvent event) {
    if (!super.shouldLog(event)) {
      return false;
    }

    switch (filterType) {
      case FilterType.excludePrefixes:
        final prefix = getMessagePrefix(event.message);
        return !prefixes.contains(prefix) && super.shouldLog(event);
      case FilterType.includePrefixes:
        final prefix = getMessagePrefix(event.message);
        return prefixes.contains(prefix) && super.shouldLog(event);
    }
  }
}
