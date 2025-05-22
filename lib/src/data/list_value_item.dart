import 'dart:core';

import 'data_item.dart';
import 'item.dart';

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

class ListValueItem extends Item {
  ListValueItem.fromFields(super.fields) : super.fromFields() {
    assert(itemType == ItemType.listsOfValues, 'ListValueItem must be of type listValue');
  }

  ValueItemType get valueItemType => ValueItemType.values.byName(this['type']);

  String get name => this['name'];

  String get title => this['title'];

  String get description => this['description'];

  int get order => this['order'] ?? -1;

  @override
  ItemType get itemType => ItemType.listsOfValues;

  @override
  String toString() => '${valueItemType.name}:$name';
}
