import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wonder/src/providers/facilities_provider.dart';
import 'package:wonder/src/widgets/cards/facility_card.dart';
import 'package:wonder/src/widgets/lists/item_list_view.dart';

import '../../data/facility.dart';
import '../async/async_value_widget.dart';

class FacilityList extends ConsumerWidget {
  const FacilityList({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueProviderWidget<List<Facility>>(facilityListProvider, (
      List<Facility> facilities,
      _,
      __,
    ) {
      return ItemListView<Facility>(
        facilities,
        itemBuilder: FacilityCard.new,
      );
    });
  }
}
