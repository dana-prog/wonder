import 'log_utils.dart';
import 'logger_types.dart';

class AppLogBasicPrinter extends LogPrinter {
  @override
  List<String> log(LogEvent event) {
    return [
      (event.message is Map && event.message.containsKey('message'))
          ? event.message['message'].toString()
          : event.message.toString(),
    ];
  }
}

class AppLogPrettyPrinter extends PrettyPrinter {
  AppLogPrettyPrinter()
      : super(
          excludePaths: ['package:mada_data/utils/app_logger/script_logger.dart'],
        );
  @override
  String stringifyMessage(message) {
    // remove the "I/flutter (xxxxx): " prefix
    String finalMessage = super.stringifyMessage(message);

    final parts = getMessageParts(finalMessage);

    final prefix = parts.item1;
    final messageText = parts.item2;

    return prefix ? '[$prefix] $messageText' : messageText;
  }
}
