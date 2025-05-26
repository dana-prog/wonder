import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wonder/src/providers/facilities_provider.dart';
import 'package:wonder/src/widgets/cards/facility_card.dart';
import 'package:wonder/src/widgets/lists/item_list.dart';

import '../../data/facility_item.dart';
import '../../resources/labels.dart';
import '../async/async_value_widget.dart';
import '../progress_indicator/circular_progress_indicator.dart';

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
        return ItemList<FacilityItem>(
          facilities.where((f) => f.number > 100).toList(),
          itemBuilder: (FacilityItem facility) => FacilityCard(
            facility: facility,
            onDelete: (FacilityItem item) =>
                _onDelete(context: context, item: item, notifier: facilityListNotifier),
          ),
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

    await notifier.delete(item.id);

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
