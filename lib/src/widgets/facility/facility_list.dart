import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/facility_item.dart';
import '../../providers/facilities_provider.dart';
import '../../resources/labels.dart';
import '../async/async_value_widget.dart';
import '../item/item_list.dart';
import '../progress_indicator/circular_progress_indicator.dart';
import 'facility_card.dart';

class FacilityList extends ConsumerWidget {
  const FacilityList({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final facilityListNotifier = ref.read(facilityListProvider.notifier);

    return AsyncValueWidget<List<FacilityItem>>(
      asyncValue: ref.watch(facilityListProvider),
      loadingBuilder: (_) => AppProgressIndicator(),
      dataBuilder: (
        List<FacilityItem> facilities,
        BuildContext context,
      ) {
        return RefreshIndicator(
          child: ItemList<FacilityItem>(
            items: facilities.where((f) => f.number > 100).toList(),
            itemBuilder: (FacilityItem facility) => FacilityCard(
              facility: facility,
              onDelete: (FacilityItem item) =>
                  _onDelete(context: context, item: item, notifier: facilityListNotifier),
            ),
          ),
          onRefresh: () async => await facilityListNotifier.refresh(),
        );
      },
    );
  }

  void _onDelete({
    required BuildContext context,
    required FacilityItem item,
    required FacilityListNotifier notifier,
  }) async {
    final messenger = ScaffoldMessenger.of(context);
    final confirmed = await _confirmDelete(context: context, facility: item);
    if (confirmed != true) return;

    await notifier.delete(item);

    _notifyDeleted(messenger, item);
  }

  Future<bool> _confirmDelete({
    required BuildContext context,
    required FacilityItem facility,
  }) async {
    final res = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${Labels.delete}?'),
        content: Text(Confirmations.delete(facility)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(
              onPressed: () => Navigator.pop(context, true), child: const Text(Labels.delete)),
        ],
      ),
    );
    return res ?? false;
  }

  void _notifyDeleted(
    ScaffoldMessengerState sm,
    FacilityItem item,
  ) =>
      sm.showSnackBar(
        SnackBar(
          content: Text(Notifications.deleted(item)),
        ),
      );
}
