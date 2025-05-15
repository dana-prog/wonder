import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wonder/src/providers/facilities_provider.dart';
import 'package:wonder/src/widgets/lists/item_list_view.dart';

import '../async/async_value_widget.dart';

class FacilityList extends ConsumerWidget {
  const FacilityList({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueProviderWidget<List<dynamic>>(facilityListProvider, (
      List<dynamic> facilities,
      _,
      __,
    ) {
      return ItemListView(facilities);
    });
  }
}
