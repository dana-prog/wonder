import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wonder/src/providers/client_provider.dart';
import 'package:wonder/src/wix/sdk/client.dart';

import '../data/facility_item.dart';
import '../logger.dart';

// TODO: generalize to create ItemProvider
// TODO: add an option to refresh the data (and validate that until refresh all clients use the same list)

class FacilityListNotifier extends StateNotifier<AsyncValue<List<FacilityItem>>> {
  final Client client;

  FacilityListNotifier(Ref ref)
      : client = ref.read(clientProvider),
        super(const AsyncLoading()) {
    _load();
  }

  Future<void> _load() async {
    try {
      final items = await client.fetchItems<FacilityItem>(itemType: 'facility');
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
    return await client.updateItem(item);
  }

  Future<void> delete(FacilityItem item) async {
    logger.d('[FacilityListNotifier.delete] $item');
    await client.deleteItem(item);
    state = state.whenData((items) {
      return [
        for (final i in items)
          if (i.id != item.id) i
      ];
    });
  }

  void onItemDeleted(FacilityItem item) {
    state = state.whenData((items) {
      return [
        for (final i in items)
          if (i.id != item.id) i
      ];
    });
  }
}

final facilityListProvider =
    StateNotifierProvider<FacilityListNotifier, AsyncValue<List<FacilityItem>>>(
  ((ref) => FacilityListNotifier(ref)),
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
