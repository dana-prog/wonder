import 'package:wonder/src/data/item.dart';
import 'package:wonder/src/data/value_item.dart';

enum DataItemType {
  facility,
  ticket;

  String get dataCollectionId {
    switch (this) {
      case DataItemType.facility:
        return 'facilities';
      case DataItemType.ticket:
        return 'tickets';
    }
  }

  static DataItemType fromCollectionId(String id) {
    switch (id) {
      case 'facilities':
        return DataItemType.facility;
      case 'tickets':
        return DataItemType.ticket;
      default:
        throw Exception('Unknown dataCollectionId: $id');
    }
  }
}

class DataItem extends Item {
  final ListsOfValues listsOfValues;

  DataItem(super.fields, this.listsOfValues);

  DataItemType get dataItemType => DataItemType.fromCollectionId(this['dataCollectionId']);

  @override
  String toString() {
    return '${dataItemType.name}:$id';
  }
}
