import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:wonder/src/widgets/items/facility/fields/facility_dropdowns.dart';
import 'package:wonder/src/widgets/items/facility/fields/room_count_dropdown.dart';
import 'package:wonder_widgetbook/src/folders.dart';

const _folder = '${FolderNames.facility}/${FolderNames.editors}';

final _typeId = 'facilityType_villa';
@UseCase(name: 'Type', type: FacilityTypeDropdown, path: _folder)
Widget type(BuildContext _) => FacilityTypeDropdown(selectedId: _typeId);

final _subtypeId = 'facilitySubtype_a';
@UseCase(name: 'Subtype', type: FacilitySubtypeDropdown, path: _folder)
Widget subtype(BuildContext _) => FacilitySubtypeDropdown(selectedId: _subtypeId);

final _statusId = 'facilityStatus_operational';
@UseCase(name: 'Status', type: FacilityStatusDropdown, path: _folder)
Widget status(BuildContext _) => FacilityStatusDropdown(selectedId: _statusId);

final _roomCount = 3;
@UseCase(name: '# Rooms', type: RoomCountDropdown, path: _folder)
Widget roomCount(BuildContext _) => RoomCountDropdown(value: _roomCount);

final _number = 104;
@UseCase(name: '# Rooms', type: RoomCountDropdown, path: _folder)
Widget number(BuildContext _) => RoomCountDropdown(value: _number);
