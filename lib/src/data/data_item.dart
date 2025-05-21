import 'package:wonder/src/data/item.dart';

enum DataItemType {
  facility,
  ticket,
  listsOfValues,
  user;

  String get pluralName {
    switch (this) {
      case DataItemType.facility:
        return 'facilities';
      case DataItemType.ticket:
        return 'tickets';
      case DataItemType.listsOfValues:
        return 'lists_of_values';
      case DataItemType.user:
        return 'users';
    }
  }

  static DataItemType fromPluralName(String name) {
    switch (name) {
      case 'facilities':
        return DataItemType.facility;
      case 'tickets':
        return DataItemType.ticket;
      default:
        throw Exception('Unknown type: $name');
    }
  }
}

abstract class DataItem extends Item {
  DataItem.fromDataCollection(super.fields);

  DataItemType get dataItemType;

  @override
  String toString() {
    return '${dataItemType.name}:$id';
  }
}
