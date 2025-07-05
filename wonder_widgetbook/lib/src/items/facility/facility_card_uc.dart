import 'package:flutter/material.dart';
import 'package:wonder/src/data/facility_item.dart';
import 'package:wonder/src/widgets/items/facility/facility_card.dart';

import '../../utils/widgetbook_data.dart';

final items = [
  FacilityItem(
    id: '1',
    number: 1,
    status: WidgetbookData.lists['facilityStatus']!['planning']!.id,
    type: WidgetbookData.lists['facilityType']!['villa']!.id,
    subtype: WidgetbookData.lists['facilitySubtype']!['a']!.id,
    owner: WidgetbookData.users['dana.shalev']!.id,
    roomCount: 1,
  ),
  FacilityItem(
    id: '2',
    number: 2,
    status: WidgetbookData.lists['facilityStatus']!['planning']!.id,
    type: WidgetbookData.lists['facilityType']!['villa']!.id,
    subtype: WidgetbookData.lists['facilitySubtype']!['b']!.id,
    owner: WidgetbookData.users['ziv.shalev']!.id,
    roomCount: 2,
  ),
  FacilityItem(
    id: '3',
    number: 3,
    status: WidgetbookData.lists['facilityStatus']!['construction']!.id,
    type: WidgetbookData.lists['facilityType']!['villa']!.id,
    subtype: WidgetbookData.lists['facilitySubtype']!['a']!.id,
    owner: WidgetbookData.users['yuval.birman']!.id,
    roomCount: 3,
  ),
  FacilityItem(
    id: '4',
    number: 4,
    status: WidgetbookData.lists['facilityStatus']!['ready']!.id,
    type: WidgetbookData.lists['facilityType']!['villa']!.id,
    subtype: WidgetbookData.lists['facilitySubtype']!['b']!.id,
    owner: WidgetbookData.users['boaz.birman']!.id,
    roomCount: 3,
  ),
  FacilityItem(
    id: '5',
    number: 5,
    status: WidgetbookData.lists['facilityStatus']!['operational']!.id,
    type: WidgetbookData.lists['facilityType']!['villa']!.id,
    subtype: WidgetbookData.lists['facilitySubtype']!['b']!.id,
    roomCount: 5,
  ),
];

Widget facilityCard(
  BuildContext context,
) {
  return Column(children: items.map((item) => FacilityCard(item: item)).toList());
}
