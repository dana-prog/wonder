// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:widgetbook/widgetbook.dart' as _i1;
import 'package:wonder_widgetbook/src/facility/facility_details_page_uc.dart'
    as _i2;
import 'package:wonder_widgetbook/src/facility/facility_fields_editors_uc.dart'
    as _i3;
import 'package:wonder_widgetbook/src/platform/chip_uc.dart' as _i4;

final directories = <_i1.WidgetbookNode>[
  _i1.WidgetbookCategory(
    name: 'Facility',
    children: [
      _i1.WidgetbookComponent(
        name: 'FacilityDetailsPage',
        useCases: [
          _i1.WidgetbookUseCase(
            name: 'Edit',
            builder: _i2.editFacility,
          ),
          _i1.WidgetbookUseCase(
            name: 'New',
            builder: _i2.newFacility,
          ),
        ],
      ),
      _i1.WidgetbookCategory(
        name: 'Editors',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'FacilityStatusDropdown',
            useCase: _i1.WidgetbookUseCase(
              name: 'Status',
              builder: _i3.status,
            ),
          ),
          _i1.WidgetbookLeafComponent(
            name: 'FacilitySubtypeDropdown',
            useCase: _i1.WidgetbookUseCase(
              name: 'Subtype',
              builder: _i3.subtype,
            ),
          ),
          _i1.WidgetbookLeafComponent(
            name: 'FacilityTypeDropdown',
            useCase: _i1.WidgetbookUseCase(
              name: 'Type',
              builder: _i3.type,
            ),
          ),
          _i1.WidgetbookLeafComponent(
            name: 'RoomCountDropdown',
            useCase: _i1.WidgetbookUseCase(
              name: '# Rooms',
              builder: _i3.roomCount,
            ),
          ),
        ],
      ),
    ],
  ),
  _i1.WidgetbookCategory(
    name: 'Platform',
    children: [
      _i1.WidgetbookCategory(
        name: 'chip',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'Chip',
            useCase: _i1.WidgetbookUseCase(
              name: 'Default',
              builder: _i4.defaultChip,
            ),
          )
        ],
      )
    ],
  ),
];
