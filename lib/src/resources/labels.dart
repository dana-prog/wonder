import 'package:wonder/src/utils/string_extension.dart';

import '../data/facility_item.dart';
import '../data/item.dart';

class Titles {
  static const String app = 'Facility Management';
  static const String tickets = 'Tickets';
  static const String more = 'More';
  static const String theme = 'Theme';
}

class Labels {
  static const String noDataFound = 'No Data Found';
  static const String save = 'Save';
  static const String edit = 'Edit';
  static const String delete = 'Delete';
  static const String loading = 'Loading';
  static const String selectOption = 'Select Option';
  static String facilityRoomCount(int count) => count == 1 ? '$count Bedroom' : '$count Bedrooms';
  static String noItem(String? typeName) => '${typeName?.capitalize() ?? 'Item'} Not Set';
  static String newItem(String itemType) => 'New ${ItemsLabels.getSingularLabel(itemType)}';
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
      singleLabel: 'Villa',
      pluralLabel: 'Villas',
      shortTitle: (Item item) {
        assert(item is FacilityItem, 'Expected FacilityItem, got ${item.runtimeType}');
        final facilityItem = item as FacilityItem;
        return '${ItemsLabels.getSingularLabel(facilityItem.itemType)} ${facilityItem.displayNumber}';
      },
      fieldLabels: {
        'number': 'Number',
        'type': 'Type',
        'subtype': 'Subtype',
        'status': 'Status',
        'owner': 'Owner',
        'roomCount': '# Rooms',
        'pictures': 'Pictures',
      },
    ),
    'ticket': ItemLabels(
      itemType: 'ticket',
      singleLabel: 'Ticket',
      pluralLabel: 'Tickets',
      shortTitle: (Item item) => item.title,
      fieldLabels: {},
    ),
  };

  static Map<String, String> getFieldLabels(String itemType) =>
      _getItemLabels(itemType).fieldLabels;

  static String getShortTitle(Item item) => _getItemLabels(item.itemType).shortTitle(item);

  static String getSingularLabel(String itemType) => _getItemLabels(itemType).singleLabel;

  static String getPluralLabel(String itemType) => _getItemLabels(itemType).pluralLabel;

  static ItemLabels _getItemLabels(String itemType) {
    final labels = itemsLabels[itemType];
    if (labels == null) {
      throw Exception('No labels found for item type: $itemType');
    }
    return labels;
  }
}

class ItemLabels {
  final Map<String, String> fieldLabels;
  final String itemType;
  final String singleLabel;
  final String pluralLabel;
  final String Function(Item item) shortTitle;

  ItemLabels({
    required this.itemType,
    required this.shortTitle,
    this.singleLabel = 'Item',
    this.pluralLabel = 'Items',
    required this.fieldLabels,
  });
}
