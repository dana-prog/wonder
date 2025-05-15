import 'package:tuple/tuple.dart';

Tuple2 getMessageParts(String message) {
  RegExp regExp = RegExp(r'\[(.*?)\]\s*(.*)');
  Match? match = regExp.firstMatch(message);
  String? prefix = match?.group(1);
  String operation = prefix == null ? message : match?.group(2) ?? 'n/a';

  return Tuple2(prefix, operation);
}

String? getMessagePrefix(String message) => getMessageParts(message).item1;
