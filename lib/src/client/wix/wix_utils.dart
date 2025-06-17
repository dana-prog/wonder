import '../../data/item.dart';
import '../../data/metadata.dart';

T dataItemToItem<T extends Item>(Map<String, dynamic> dataItem) {
  final dataCollectionId = dataItem['dataCollectionId'];
  final id = dataItem['id'];
  final data = dataItem['data'];

  final itemMetadata = Metadata().getByCollectionId(dataCollectionId);
  final itemType = itemMetadata.name;

// TODO: set all fields on creation (we separated because the operator = did additional work)
  final item = itemMetadata.deserializer({
    'id': id,
    'itemType': itemType,
  });

  for (var fieldsEntry in data.entries) {
    item[fieldsEntry.key] = fieldsEntry.value;
  }
  return item as T;
}
