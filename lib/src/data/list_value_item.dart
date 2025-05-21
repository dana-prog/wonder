import 'dart:core';

import 'data_item.dart';

enum ValueItemType {
  facilityStatus,
  facilityType,
  facilitySubtype,
  ticketStatus,
  ticketSeverity,
  domain;

  String getLabel() {
    switch (this) {
      case ValueItemType.facilityStatus:
        return 'Status';
      case ValueItemType.facilityType:
        return 'Type';
      case ValueItemType.facilitySubtype:
        return 'Subtype';
      case ValueItemType.ticketStatus:
        return 'Status';
      case ValueItemType.ticketSeverity:
        return 'Severity';
      case ValueItemType.domain:
        return 'Domain';
    }
  }
}

class ListValueItem extends DataItem {
  ListValueItem.fromDataCollection(super.fields) : super.fromDataCollection() {
    assert(dataItemType == DataItemType.listsOfValues, 'ListValueItem must be of type listValue');
  }

  ValueItemType get valueItemType => ValueItemType.values.byName(this['type']);

  String get name => this['name'];

  String get title => this['title'];

  String get description => this['description'];

  int get order => this['order'] ?? -1;

  @override
  DataItemType get dataItemType => DataItemType.listsOfValues;

  @override
  String toString() => '${valueItemType.name}:$name';
}
