import 'package:flutter/material.dart';

import '../../../data/facility_item.dart';
import '../item_list.dart';
import 'facility_card.dart';

class FacilitiesMainView extends StatelessWidget {
  const FacilitiesMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return ItemList(
        itemType: 'facility',
        itemBuilder: (context, item) => FacilityCard(
              item: item as FacilityItem,
            ));
  }
}
