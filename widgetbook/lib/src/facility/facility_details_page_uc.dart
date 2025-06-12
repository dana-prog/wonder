import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:wonder/mock/mock_data.dart';
import 'package:wonder/src/data/facility_item.dart';
import 'package:wonder/src/widgets/items/facility/facility_details_page.dart';
import 'package:wonder_widgetbook/src/folders.dart';

const _folder = FolderNames.facility;

final _facility = MockData.facilities[1];

@UseCase(name: 'Edit', type: FacilityDetailsPage, path: _folder)
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

@UseCase(name: 'New', type: FacilityDetailsPage, path: _folder)
Widget newFacility(BuildContext context) {
  FacilityItem? initialItem;

  return StatefulBuilder(
    builder: (context, setState) => FacilityDetailsPage(
        initialItem: initialItem,
        save: (item) {
          setState(() => initialItem = item);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Saved Item')));
        }),
  );
}
