import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:wonder/src/data/facility_item.dart';
import 'package:wonder/src/widgets/items/facility/facility_card.dart';

import '../folders.dart';

const _folder = FolderNames.facility;

@UseCase(name: 'default', type: FacilityCard, path: _folder)
Widget facilityCard(BuildContext context) {
  final items = [
    FacilityItem(
        id: '1',
        number: 1,
        status: 'facilityStatus_notStarted',
        type: 'facilityType_villa',
        subtype: 'facility_subtype_a',
        owner: 'dana_shalev',
        roomCount: 1),
    FacilityItem(
        id: '2',
        number: 2,
        status: 'facilityStatus_planning',
        type: 'facilityType_villa',
        subtype: 'facility_subtype_b',
        owner: 'ziv_shalev',
        roomCount: 2),
    FacilityItem(
        id: '3',
        number: 3,
        status: 'facilityStatus_construction',
        type: 'facilityType_villa',
        subtype: 'facility_subtype_a',
        owner: 'yuval_birman',
        roomCount: 3),
    FacilityItem(
        id: '4',
        number: 4,
        status: 'facilityStatus_ready',
        type: 'facilityType_villa',
        subtype: 'facility_subtype_b',
        owner: 'boaz_birman',
        roomCount: 3),
    FacilityItem(
        id: '5',
        number: 5,
        status: 'facilityStatus_operational',
        type: 'facilityType_villa',
        subtype: 'facility_subtype_b',
        roomCount: 5),
  ];
  return Column(
      children: items
          .map(
            (item) => FacilityCard(item: item),
          )
          .toList());
}
