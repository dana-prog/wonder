class Item extends Fields {
  Item(super.fields);

  String get id => this['id'];

  String get dataCollectionId => this['dataCollectionId'];
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
            "Field $fieldName not found for Fields = '{$this()}'",
          );
  }

  void operator []=(String fieldName, dynamic fieldValue) {
    _fields[fieldName] = fieldValue;
  }

  Iterable<String> get fieldNames => _fields.keys;

  _fieldEntryToStr(MapEntry<String, dynamic> entry) => '${entry.key}: ${entry.value.toString()}';

  @override
  String toString() => '{'
      '${_fields.entries.map(_fieldEntryToStr).join(', ')}'
      '}';

  int compareTo(Fields other) {
    if (this['id'] == other['id']) return 0;
    if (this['id'] > other['id']) return 1;
    return -1;
  }
}
