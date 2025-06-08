import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:wonder/mock/mock_data.dart';
import 'package:wonder/src/widgets/items/facility/facility_details_page.dart';
import 'package:wonder_widgetbook/src/folders.dart';

final facility = MockData.facilities[0];

const _folder = FolderNames.facility;

@UseCase(name: 'Edit', type: FacilityDetailsPage, path: _folder)
FacilityDetailsPage editFacility(_) {
  return FacilityDetailsPage(initialItem: facility, save: (_) {});
}

@UseCase(name: 'New', type: FacilityDetailsPage, path: _folder)
FacilityDetailsPage newFacility(_) {
  return FacilityDetailsPage(initialItem: null, save: (_) {});
}
