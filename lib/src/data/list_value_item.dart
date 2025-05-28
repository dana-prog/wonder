import 'dart:core';

import 'package:flutter/material.dart';

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

const _icons = {
  'facilityStatus': {
    'notStarted': Icons.not_started_outlined,
    'planning': Icons.design_services,
    'construction': Icons.construction,
    'ready': Icons.check_circle_outline,
    'operational': Icons.check_circle,
  },
};
// 0xFFc25a5a, // muted red
// 0xFFe0b94d, // warm yellow
// 0xFFa86e3c, // soft brown
// 0xFFb278d3, // plum (matches your purple)
// 0xFFef9a57, // orange-peach
// 0xFFa2c65b, // olive green
// 0xFFe06493, // soft raspberry pink
const _colors = {
  'facilityStatus': {
    'notStarted': Color(0xFF6e7289),
    'planning': Color(0xFF8465c6),
    'construction': Color(0xFFa86e3c),
    'ready': Color(0xFF6e9ce3),
    'operational': Color(0xFF32BB87)
  },
  'facilityType': {
    'villa': Color(0xFF5bc0de),
  },
  'facilitySubtype': {
    'a': Color(0xFFdc7fbf),
    'b': Color(0xFF82735c),
  },
  'ticketStatus': {
    'open': Color(0xFF6e7289),
    'inProgress': Color(0xFF8465c6),
    'resolved': Color(0xFFe07657),
    'closed': Color(0xFF6e9ce3),
    'reopened': Color(0xFF32BB87)
  },
};

class ListValueItem extends Item {
  ListValueItem.fromFields(super.fields)
      : assert(fields['itemType'] == 'listValue',
            'ListValueItem must be of type listValue and not ${fields['itemType']}');

  String get valueItemType => this['type'];

  String get name => this['name'];

  String get description => this['description'];

  int get order => this['order'] ?? -1;

  IconData get icon {
    assert(_icons.containsKey(valueItemType), 'No icon defined for $valueItemType');
    assert(_icons[valueItemType]!.containsKey(name), 'No icon defined for $valueItemType');

    return _icons[valueItemType]![name] ?? Icons.question_mark_outlined;
  }

  @override
  Color get color {
    assert(_colors.containsKey(valueItemType), 'No color defined for $valueItemType');
    assert(_colors[valueItemType]!.containsKey(name), 'No color defined for $valueItemType:$name');

    return _colors[valueItemType]![name] ?? Colors.white;
  }

  @override
  String toString() => '$valueItemType:$name';
}
