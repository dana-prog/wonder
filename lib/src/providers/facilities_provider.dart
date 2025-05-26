import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wonder/src/providers/client_provider.dart';

import '../data/facility_item.dart';
import '../logger.dart';

// TODO: generalize to create ItemProvider
// TODO: add an option to refresh the data (and validate that until refresh all clients use the same list)

class FacilityListNotifier extends StateNotifier<AsyncValue<List<FacilityItem>>> {
  FacilityListNotifier(this.ref) : super(const AsyncLoading()) {
    _load();
  }

  final Ref ref;

  Future<void> _load() async {
    final wixClient = ref.read(clientProvider);
    try {
      final items = await wixClient.fetchItems<FacilityItem>(itemType: 'facility');
      state = AsyncData(items);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> refresh() {
    logger.d('[FacilityListNotifier.refresh]');
    state = AsyncData([]);
    state = const AsyncLoading();
    return _load();
  }

  Future<FacilityItem> update(FacilityItem item) async {
    logger.d('[FacilityListNotifier.update] $item');
    final wixClient = ref.read(clientProvider);
    return await wixClient.updateItem(item);
  }

  Future<void> delete(FacilityItem item) async {
    logger.d('[FacilityListNotifier.delete] $item');
    final wixClient = ref.read(clientProvider);
    await wixClient.deleteItem(item);
    await refresh();
  }
}

final facilityListProvider =
    StateNotifierProvider<FacilityListNotifier, AsyncValue<List<FacilityItem>>>(
  (ref) => FacilityListNotifier(ref),
);

final facilityProvider = FutureProvider.family<FacilityItem, String>((
  ref,
  id,
) async {
  final wixClient = ref.watch(clientProvider);
  return await wixClient.fetchItem<FacilityItem>(
    itemType: 'facility',
    id: id,
  );
});

// final _allFacilitiesProvider = FutureProvider<_FacilityList>((
//   ref,
// ) async {
//   if (_facilityList == null) {
//     final wixClient = ref.watch(wixClientProvider);
//     final facilities = await wixClient.fetchItems(
//       itemType: ItemType.facility,
//       itemConstructor: FacilityItem.fromFields,
//       sortBy: [
//         ('number', SortOrder.ascending),
//       ],
//     );
//
//     _facilityList = _FacilityList(facilities);
//   }
//
//   return _facilityList!;
// });
//
// final facilityListProvider = FutureProvider<List<FacilityItem>>((
//   ref,
// ) async {
//   final facilityList = await ref.watch(_allFacilitiesProvider.future);
//   return facilityList.facilities;
// });
//
// final facilityProvider = FutureProvider.family<FacilityItem, String>((
//   ref,
//   id,
// ) async {
//   final facilityList = await ref.watch(_allFacilitiesProvider.future);
//   return facilityList.getFacilityById(id);
// });
//
// _FacilityList? _facilityList;
//
// class _FacilityList {
//   late List<FacilityItem> _facilities;
//   late Map<String, FacilityItem> _facilitiesById;
//
//   _FacilityList(List<FacilityItem> facilities) {
//     _facilities = facilities;
//     _facilitiesById = {};
//     for (var item in facilities) {
//       _facilitiesById[item.id] = item;
//     }
//   }
//
//   FacilityItem getFacilityById(String id) {
//     final item = _facilitiesById[id];
//     if (item == null) {
//       throw Exception('Facility with id $id not found');
//     }
//     return item;
//   }
//
//   List<FacilityItem> get facilities => _facilities;
// }
