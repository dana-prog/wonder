import 'package:flutter/material.dart';
import 'package:wonder/src/data/facility_item.dart';
import 'package:wonder/src/widgets/items/facility/facility_details_page.dart';

import '../../utils/widgetbook_data.dart';

final _facility = WidgetbookData.facilities[0];

Widget editFacility(BuildContext context) {
  FacilityItem? initialItem = _facility;
  return StatefulBuilder(builder: (context, setState) {
    return FacilityDetailsPage(
      initialItem: initialItem,
      save: (item) {
        setState(() => initialItem = item);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Saved Item')));
      },
    );
  });
}

Widget newFacility(BuildContext context) {
  FacilityItem? initialItem;

  return StatefulBuilder(
    builder: (context, setState) => FacilityDetailsPage(
      initialItem: initialItem,
      save: (item) {
        // simulate item added
        setState(() => initialItem = FacilityItem.fromFields({...item.fields, 'id': 'new-id'}));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Saved Item')));
      },
    ),
  );
}
