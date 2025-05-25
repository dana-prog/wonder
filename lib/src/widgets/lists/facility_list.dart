import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wonder/src/providers/facilities_provider.dart';
import 'package:wonder/src/widgets/cards/facility_card.dart';
import 'package:wonder/src/widgets/lists/item_list.dart';

import '../../data/facility_item.dart';
import '../async/async_value_widget.dart';
import '../progress_indicator/circular_progress_indicator.dart';

class FacilityList extends ConsumerWidget {
  const FacilityList({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget<List<FacilityItem>>(
      asyncValue: ref.watch(facilityListProvider),
      loadingBuilder: (_) => AppProgressIndicator(),
      dataBuilder: (
        List<FacilityItem> facilities,
        _,
      ) {
        return ItemList<FacilityItem>(
          facilities,
          itemBuilder: (FacilityItem facility) => FacilityCard(facility),
        );
      },
    );
  }
}
