import 'dart:core';

import 'item.dart';

enum ValueItemType {
  facilityStatus,
  facilityType,
  facilitySubtype,
  ticketStatus,
  ticketSeverity,
  domain;
}

class ValueItem extends Item {
  ValueItem(super.fields);

  ValueItemType get valueItemType => ValueItemType.values.byName(this['type']);

  String get name => this['name'];

  String get title => this['title'];

  String get description => this['description'];

  int get order => this['order'] ?? -1;

  @override
  String toString() => '${valueItemType.name}:$name';
}

class ListsOfValues {
  late Map<String, ValueItem> byId = {};
  late Map<ValueItemType, Map<String, ValueItem>> byName = {};

  ListsOfValues(List<ValueItem> valueItems) {
    for (var item in valueItems) {
      byName[item.valueItemType] ??= {};

      byId[item.id] = item;
      byName[item.valueItemType]![item.name] = item;
    }
  }

  ValueItem getValue(String id) {
    final item = byId[id];
    if (item == null) {
      throw Exception('Item with id $id not found');
    }

    return item;
  }

  ValueItem getValueByName(ValueItemType type, String name) {
    final list = byName[type];
    if (list == null) {
      throw Exception('No items found for type $type');
    }

    final item = list[name];
    if (item == null) {
      throw Exception('Item with name $name not found in type $type');
    }

    return item;
  }

  List<ValueItem> getList(ValueItemType type) {
    final list = byName[type];
    if (list == null) {
      throw Exception('No items found for type $type');
    }
    return list.values.toList();
  }
}
