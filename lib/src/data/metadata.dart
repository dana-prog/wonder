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

Map<String, dynamic> _defaultSerializer(Item item) => item.fields;

class TypeMetadata<T extends Item> {
  final String name;
  final String dataCollectionId;
  final Map<String, dynamic> Function(T item) serializer;
  final T Function(Map<String, dynamic> fields) deserializer;
  final List<(String, SortOrder)> defaultSortBy;

  TypeMetadata({
    required this.name,
    required this.dataCollectionId,
    required this.deserializer,
    this.serializer = _defaultSerializer,
    this.defaultSortBy = const [],
  });
}

final facilityMetadata = TypeMetadata(
  name: 'facility',
  dataCollectionId: 'facilities',
  deserializer: FacilityItem.fromFields,
  defaultSortBy: [
    ('number', SortOrder.ascending),
  ],
);

final userMetadata = TypeMetadata(
  name: 'user',
  dataCollectionId: 'users',
  deserializer: UserItem.fromFields,
  defaultSortBy: [
    ('firstName', SortOrder.ascending),
    ('nickname', SortOrder.ascending),
    ('lastName', SortOrder.ascending),
  ],
);

final listValueMetadata = TypeMetadata(
  name: 'listValue',
  dataCollectionId: 'lists_values',
  deserializer: ListValueItem.fromFields,
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

  TypeMetadata getByName(String name) {
    assert(_byName.containsKey(name), 'No metadata found for $name');
    return _byName[name]!;
  }

  TypeMetadata getByCollectionId(String collectionId) {
    assert(_byCollectionId.containsKey(collectionId), 'No metadata found for $collectionId');
    return _byCollectionId[collectionId]!;
  }
}
