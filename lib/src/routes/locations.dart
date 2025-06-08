class Locations {
  // static const initial = '/facility/3c34ee55-05e0-4107-9cd1-b720fe494592';
  // static const initial = '$more/${MoreSubLocations.performancePlayground}';
  static const initial = facilities;
  static const tickets = '/tickets';
  static const facilities = '/facilities';
  static const editItem = '/item/:itemType/:itemId';
  static const newItem = '/new_item/:itemType';
  static const image = '/image/:path';
  static const more = '/more';
}

class MoreSubLocations {
  static const debug = 'debug';
  static const themePlayground = 'theme';
}
