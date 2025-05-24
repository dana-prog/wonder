class Titles {
  static const String app = 'Facility Management';
  static const String tickets = 'Tickets';
  static const String facilities = 'Facilities';
  static const String more = 'More';
  static const String theme = 'Theme';
  static const String debug = 'Debug';
}

class Labels {
  static const String noDataFound = 'No Data Found';
  static const String noOwner = 'No Owner';
  static const String save = 'Save';
  static String facilityRoomCount(int count) {
    return count == 1 ? '$count Bedroom' : '$count Bedrooms';
  }
}

class ItemsLabels {
  static final facility = ItemLabels({
    'number': 'Number',
    'type': 'Type',
    'subtype': 'Subtype',
    'status': 'Status',
    'owner': 'Owner',
    'roomCount': 'Rooms',
  });
}

class ItemLabels {
  final Map<String, String> fields;

  ItemLabels(this.fields);
}
