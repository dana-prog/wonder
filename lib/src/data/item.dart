import '../logger.dart';

class Item extends Fields {
  Item(super.fields);

  String? get id => getFieldValue<String>('id');

  // TODO: pass as a separate prop or consider removing since each type is created with its own class
  String get itemType => this['itemType'];

  String get title {
    if (!containsField('title')) {
      logger.w('Item $this does not have a title field.');
      return '';
    }

    return this['title']!;
  }

  String? get avatar => null;

  @override
  String toString() {
    return '$itemType:$id';
  }
}

abstract class Fields {
  Fields(Map<String, dynamic> fields) {
    for (var entry in fields.entries) {
      this[entry.key] = entry.value;
    }
  }
  final Map<String, dynamic> _fields = {};

  void initializeFields() {}

  bool containsField(String fieldName) {
    return _fields.containsKey(fieldName);
  }

  T? getFieldValue<T>(String fieldName, {T? defaultValue}) {
    return containsField(fieldName) ? _fields[fieldName] : defaultValue;
  }

  dynamic operator [](String fieldName) {
    return _fields.containsKey(fieldName)
        ? _fields[fieldName]
        : throw Exception(
            'Field $fieldName not found for Fields = ${toFullString()}',
          );
  }

  void operator []=(String fieldName, dynamic fieldValue) {
    _fields[fieldName] = fieldValue;
  }

  Iterable<String> get fieldNames => _fields.keys;

  Map<String, dynamic> get fields => Map<String, dynamic>.fromEntries(_fields.entries);

  @override
  String toString() => toFullString();

  String toFullString() {
    final buffer = StringBuffer();
    buffer.writeln('{');
    for (var entry in _fields.entries) {
      buffer.writeln('  ${entry.key}: ${entry.value}');
    }
    buffer.writeln('}');
    return buffer.toString();
  }

  int compareTo(Fields other) {
    if (this['id'] == other['id']) return 0;
    if (this['id'] > other['id']) return 1;
    return -1;
  }
}
