class Item extends Fields {
  static final String itemTypeFieldName = 'itemType';

  Item(super.fields);

  String get id => this['id'];

  @override
  String toString() {
    return '${this['dataCollectionId']}:$id';
  }
}

abstract class Fields {
  Fields(this._fields) {
    initializeFields();
  }
  late final Map<String, dynamic> _fields;

  void initializeFields() {}

  bool containsField(String fieldName) {
    return _fields.containsKey(fieldName);
  }

  void putIfAbsent(String fieldName, dynamic fieldValue) {
    _fields.putIfAbsent(fieldName, () => fieldValue);
  }

  dynamic operator [](String fieldName) {
    return _fields.containsKey(fieldName)
        ? _fields[fieldName]
        : throw Exception(
            "Field $fieldName not found for Fields = ${toFullString()}",
          );
  }

  void operator []=(String fieldName, dynamic fieldValue) {
    _fields[fieldName] = fieldValue;
  }

  Iterable<String> get fieldNames => _fields.keys;

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
