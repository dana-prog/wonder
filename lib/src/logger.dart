import 'utils/logger/logger.dart';
import 'utils/logger/logger_types.dart';

final logger = Logger(
  level: Level.debug,
  printer: PrettyPrinter(
    methodCount: 0,
    printEmojis: false,
    lineLength: 200,
    errorMethodCount: 20,
    // noBoxingByDefault: true,
  ),
  // filterType: FilterType.excludeDomains,
  // domains: <String>[],
  // output: DartLogOutput(),
);
