import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:wonder/mock/mock_data.dart';
import 'package:wonder/src/widgets/items/facility/facility_details_page.dart';
import 'package:wonder_widgetbook/src/folders.dart';

const _folder = FolderNames.facility;

final _facility = MockData.facilities[1];

@UseCase(name: 'Edit', type: FacilityDetailsPage, path: _folder)
FacilityDetailsPage editFacility(BuildContext _) {
  return FacilityDetailsPage(initialItem: _facility, save: (_) {});
}

@UseCase(name: 'New', type: FacilityDetailsPage, path: _folder)
FacilityDetailsPage newFacility(BuildContext _) {
  return FacilityDetailsPage(initialItem: null, save: (_) {});
}
