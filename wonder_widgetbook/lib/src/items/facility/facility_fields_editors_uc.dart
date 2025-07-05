import 'package:flutter/material.dart';
import 'package:wonder/src/widgets/items/facility/fields/facility_dropdowns.dart';
import 'package:wonder/src/widgets/items/facility/fields/facility_number_text_box.dart';
import 'package:wonder/src/widgets/items/user/users_dropdown.dart';
import 'package:wonder_widgetbook/src/utils/widgetbook_data.dart';

final _typeId = WidgetbookData.lists['facilityType']!['villa']!.id;
Widget type(BuildContext _) => FacilityTypeDropdown(selectedId: _typeId);

final _subtypeId = WidgetbookData.lists['facilitySubtype']!['a']!.id;
Widget subtype(BuildContext _) => FacilitySubtypeDropdown(selectedId: _subtypeId);

final _statusId = WidgetbookData.lists['facilityStatus']!['operational']!.id;
Widget facilityStatus(BuildContext _) => FacilityStatusDropdown(selectedId: _statusId);

final _roomCount = 3;
Widget roomCount(BuildContext _) => FacilityRoomCountDropdown(value: _roomCount);

final _number = 104;
Widget number(BuildContext _) => FacilityNumberTextBox(initialValue: _number);

final _ownerId = WidgetbookData.users['danashalev100@gmail.com']!.id;
Widget owner(BuildContext _) => UsersDropdownConsumer(selectedId: _ownerId);
