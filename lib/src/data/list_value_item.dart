import 'dart:core';

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
  ListValueItem.fromFields(super.fields)
      : assert(fields['itemType'] == 'listValue',
            'ListValueItem must be of type listValue and not ${fields['itemType']}');

  String get type => this['type'];

  String get name => this['name'];

  String get description => this['description'];

  int get order => this['order'] ?? -1;
}
