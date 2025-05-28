import 'package:wonder/src/utils/string_extension.dart';

import '../data/facility_item.dart';
import '../data/item.dart';

class Titles {
  static const String app = 'Facility Management';
  static const String tickets = 'Tickets';
  static const String facilities = 'Facilities';
  static const String more = 'More';
  static const String theme = 'Theme';
  static const String debug = 'Debug';
  static const String printMyMember = 'Print My Member';
}

class Labels {
  static const String noDataFound = 'No Data Found';
  static const String noUser = 'No Owner';
  static const String save = 'Save';
  static const String edit = 'Edit';
  static const String delete = 'Delete';
  static const String loading = 'Loading';
  static String facilityRoomCount(int count) => count == 1 ? '$count Bedroom' : '$count Bedrooms';
}

class ConfirmationMessages {
  static String delete(Item item) =>
      'Are you sure you want to delete ${ItemsLabels.getShortTitle(item)}?';

  static String update(Item item) =>
      'Are you sure you want to update ${ItemsLabels.getShortTitle(item)}?';
}

class NotificationMessages {
  static String itemEvent(String itemEventType, Item item) {
    final shortTitle = ItemsLabels.getShortTitle(item);
    switch (itemEventType) {
      case 'create':
        return created(item);
      case 'update':
        return updated(item);
      case 'delete':
        return deleted(item);
      default:
        return 'Unknown event $itemEventType for $shortTitle';
    }
  }

  static String created(Item item) => '${ItemsLabels.getShortTitle(item)} created.'.capitalize();

  static String deleted(Item item) => '${ItemsLabels.getShortTitle(item)} deleted.'.capitalize();

  static String updated(Item item) => '${ItemsLabels.getShortTitle(item)} updated.'.capitalize();
}

class ItemsLabels {
  static final itemsLabels = <String, ItemLabels>{
    'facility': ItemLabels(
      // TODO: currently we have only 'villa' facilities. in the future either separate to different item types or change the itemType here to 'facility'
      itemType: 'villa',
      shortTitle: (Item item) {
        if (item is! FacilityItem) {
          throw Exception('Expected FacilityItem, got ${item.runtimeType}');
        }

        return '${ItemsLabels.getTypeLabel(item.itemType)} #${item.number}';
      },
      fieldTitles: {
        'number': 'Number',
        'type': 'Type',
        'subtype': 'Subtype',
        'status': 'Status',
        'owner': 'Owner',
        'roomCount': '# Rooms',
      },
    ),
  };

  static Map<String, String> getFieldLabels(String itemType) {
    final labels = itemsLabels[itemType];
    if (labels == null) {
      throw Exception('No labels found for item type: $itemType');
    }
    return labels.fieldTitles;
  }

  static String getTypeLabel(String itemType) {
    final labels = itemsLabels[itemType];
    if (labels == null) {
      throw Exception('No labels found for item type: $itemType');
    }
    return labels.itemType;
  }

  static String getShortTitle(Item item) {
    final ItemLabels? labels = itemsLabels[item.itemType];
    if (labels == null) {
      throw Exception('No labels found for item type: ${item.itemType}');
    }
    return labels.shortTitle(item);
  }
}

class ItemLabels {
  final Map<String, String> fieldTitles;
  final String itemType;
  final String Function(Item item) shortTitle;

  ItemLabels({
    required this.itemType,
    required this.shortTitle,
    required this.fieldTitles,
  });
}
