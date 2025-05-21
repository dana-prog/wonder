import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wonder/src/data/data_item.dart';
import 'package:wonder/src/providers/wix_client_provider.dart';

import '../data/facility_item.dart';
import '../wix/sdk/wix_client.dart';

// TODO: generalize to create ItemProvider
// TODO: add an option to refresh the data

final _allFacilitiesProvider = FutureProvider<_FacilityList>((
  ref,
) async {
  if (_facilityList == null) {
    final wixClient = ref.watch(wixClientProvider);
    final facilities = await wixClient.fetchItems(
      dataCollectionId: DataItemType.facility.pluralName,
      itemConstructor: FacilityItem.fromDataCollection,
      sortBy: [
        ('number', SortOrder.ascending),
      ],
    );

    _facilityList = _FacilityList(facilities);
  }

  return _facilityList!;
});

final facilityListProvider = FutureProvider<List<FacilityItem>>((
  ref,
) async {
  final facilityList = await ref.watch(_allFacilitiesProvider.future);
  return facilityList.facilities;
});

final facilityProvider = FutureProvider.family<FacilityItem, String>((
  ref,
  id,
) async {
  final facilityList = await ref.watch(_allFacilitiesProvider.future);
  return facilityList.getFacilityById(id);
});

_FacilityList? _facilityList;

class _FacilityList {
  late List<FacilityItem> _facilities;
  late Map<String, FacilityItem> _facilitiesById;

  _FacilityList(List<FacilityItem> facilities) {
    _facilities = facilities;
    _facilitiesById = {};
    for (var item in facilities) {
      _facilitiesById[item.id] = item;
    }
  }

  FacilityItem getFacilityById(String id) {
    final item = _facilitiesById[id];
    if (item == null) {
      throw Exception('Facility with id $id not found');
    }
    return item;
  }

  List<FacilityItem> get facilities => _facilities;
}
