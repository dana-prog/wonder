import 'package:logger/logger.dart';

final logger = Logger(
  level: Level.debug,
  printer: PrettyPrinter(
    methodCount: 0,
    printEmojis: false,
    noBoxingByDefault: true,
  ),
  // filterType: FilterType.excludeDomains,
  // domains: <String>[],
  // output: DartLogOutput(),
);
