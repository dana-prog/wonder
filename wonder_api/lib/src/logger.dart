import 'package:wonder/src/utils/logger/logger.dart';
import 'package:wonder/src/utils/logger/logger_types.dart';

final logger = Logger(
  level: Level.trace,
  printer: PrettyPrinter(
    methodCount: 0,
    printEmojis: false,
    lineLength: 200,
    // noBoxingByDefault: true,
  ),
  // filterType: FilterType.excludeDomains,
  // domains: <String>[],
  // output: DartLogOutput(),
);
