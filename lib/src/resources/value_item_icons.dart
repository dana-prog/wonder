import 'package:flutter/material.dart';

import '../data/list_value_item.dart';

class ValueItemIcons {
  static final icons = {
    'facilityStatus': {
      'notStarted': Icons.not_started_outlined,
      'planning': Icons.design_services,
      'underConstruction': Icons.construction,
      'ready': Icons.check_circle_outline,
      'operational': Icons.check_circle,
    },
  };

  static IconData? getIcon(ListValueItem item) {
    return _getIcon(item.valueItemType.name, item.name);
  }

  static IconData? _getIcon(String type, String name) {
    return icons[type]?[name];
  }
}
