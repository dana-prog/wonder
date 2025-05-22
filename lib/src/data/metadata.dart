import 'facility_item.dart';
import 'item.dart';
import 'list_value_item.dart';
import 'user_item.dart';

enum SortOrder {
  ascending,
  descending;

  @override
  String toString() {
    switch (this) {
      case SortOrder.ascending:
        return 'ASC';
      case SortOrder.descending:
        return 'DESC';
    }
  }
}

class TypeMetadata<T extends Item> {
  final String name;
  final String dataCollectionId;
  final T Function(Map<String, dynamic> fields) itemConstructor;
  final List<(String, SortOrder)> defaultSortBy;

  TypeMetadata({
    required this.name,
    required this.dataCollectionId,
    required this.itemConstructor,
    this.defaultSortBy = const [],
  });
}

final facilityMetadata = TypeMetadata(
  name: 'facility',
  dataCollectionId: 'facilities',
  itemConstructor: FacilityItem.fromFields,
  defaultSortBy: [
    ('number', SortOrder.ascending),
  ],
);

final userMetadata = TypeMetadata(
  name: 'user',
  dataCollectionId: 'users',
  itemConstructor: UserItem.fromFields,
  defaultSortBy: [
    ('firstName', SortOrder.ascending),
    ('nickname', SortOrder.ascending),
    ('lastName', SortOrder.ascending),
  ],
);

final listValueMetadata = TypeMetadata(
  name: 'listValue',
  dataCollectionId: 'lists_of_values',
  itemConstructor: ListValueItem.fromFields,
  defaultSortBy: [
    ('type', SortOrder.ascending),
    ('name', SortOrder.ascending),
    ('title', SortOrder.ascending),
  ],
);

class Metadata {
  static final _all = [
    facilityMetadata,
    userMetadata,
    listValueMetadata,
  ];
  static final Metadata _instance = Metadata._internal();
  final Map<String, TypeMetadata> _byName = {};
  final Map<String, TypeMetadata> _byCollectionId = {};

  factory Metadata() {
    return _instance;
  }

  Metadata._internal() {
    for (var metadata in _all) {
      _byName[metadata.name] = metadata;
      _byCollectionId[metadata.dataCollectionId] = metadata;
    }
  }

  TypeMetadata getByName(String name) =>
      _byName[name] ?? (throw Exception('No metadata found for $name'));

  TypeMetadata getByCollectionId(String collectionId) =>
      _byCollectionId[collectionId] ?? (throw Exception('No metadata found for $collectionId'));
}
