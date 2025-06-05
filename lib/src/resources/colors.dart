import 'package:flutter/material.dart';

import '../data/item.dart';
import '../data/list_value_item.dart';

// ListValueItem
final listsValuesColors = <String, Map<String, Color>>{
  'facilityStatus': {
    'notStarted': Colors.blueGrey.shade300,
    'planning': Colors.purple.shade300,
    'construction': Colors.amber.shade300,
    'ready': Colors.blue.shade300,
    'operational': Colors.green.shade300,
  },
  'facilityType': {
    'villa': Colors.green.shade100,
  },
  'facilitySubtype': {
    'a': Colors.red.shade100,
    'b': Colors.deepPurple.shade100,
  },
  'ticketStatus': {
    // 'open': Color(0xFF6e7289),
    // 'inProgress': Color(0xFF8465c6),
    // 'resolved': Color(0xFFe07657),
    // 'closed': Color(0xFF6e9ce3),
    // 'reopened': Color(0xFF32BB87)
  },
};

// FacilityItem
final roomCountColors = <int, Color>{
  1: Colors.blue.shade100,
  2: Colors.deepPurple.shade100,
  3: Colors.amber.shade100,
  4: Colors.brown.shade100,
  5: Colors.teal.shade100,
};

Color? getItemColor(Item? item) {
  final listsValuesColors = <String, Map<String, Color>>{
    'facilityStatus': {
      'notStarted': Colors.blueGrey.shade300,
      'planning': Colors.purple.shade300,
      'construction': Colors.amber.shade300,
      'ready': Colors.blue.shade300,
      'operational': Colors.green.shade300,
    },
    'facilityType': {
      'villa': Colors.green.shade100,
    },
    'facilitySubtype': {
      'a': Colors.red.shade100,
      'b': Colors.deepPurple.shade100,
    },
    'ticketStatus': {
      // 'open': Color(0xFF6e7289),
      // 'inProgress': Color(0xFF8465c6),
      // 'resolved': Color(0xFFe07657),
      // 'closed': Color(0xFF6e9ce3),
      // 'reopened': Color(0xFF32BB87)
    },
  };

  if (item is ListValueItem) {
    final type = item.valueItemType;
    final colorMap = listsValuesColors[type];
    if (colorMap != null) {
      return colorMap[item.name];
    }
  }

  return null;
}
