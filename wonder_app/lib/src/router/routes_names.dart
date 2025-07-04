import '../data/item.dart';

class RouteNames {
  // static const initial = '/facility/3c34ee55-05e0-4107-9cd1-b720fe494592';
  // static const initial = '$more/${MoreSubLocations.performancePlayground}';
  static const initial = facilities;
  static const tickets = '/tickets';
  static const facilities = '/facilities';
  static const editItem = '/item/:itemType/:itemId';
  static const newItem = '/new_item/:itemType';
  static const file = '/file/:fileUrl';
  static const more = '/more';
}

class MoreSubLocations {
  static const debug = 'debug';
  static const themePlayground = 'theme';
}

String getItemRoute({String? itemType, String? id, Item? item}) {
  assert((itemType != null && id != null) || item != null,
      'Either itemType and id must be provided, or an item must be provided.');

  return RouteNames.editItem
      .replaceFirst(':itemType', itemType ?? item!.itemType)
      .replaceFirst(':itemId', id ?? item!.id);
}
