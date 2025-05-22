enum ItemType {
  facility,
  ticket,
  listsOfValues,
  user;

  String get pluralName {
    switch (this) {
      case ItemType.facility:
        return 'facilities';
      case ItemType.ticket:
        return 'tickets';
      case ItemType.listsOfValues:
        return 'lists_of_values';
      case ItemType.user:
        return 'users';
    }
  }

  static ItemType fromPluralName(String name) {
    switch (name) {
      case 'facilities':
        return ItemType.facility;
      case 'tickets':
        return ItemType.ticket;
      case 'users':
        return ItemType.user;
      case 'lists_of_values':
        return ItemType.listsOfValues;
      default:
        throw Exception('Unknown type: $name');
    }
  }
}
