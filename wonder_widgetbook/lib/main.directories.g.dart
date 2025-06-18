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
import 'package:wonder_widgetbook/src/debug_uc.dart' as _i8;
import 'package:wonder_widgetbook/src/facility/facility_card_uc.dart' as _i3;
import 'package:wonder_widgetbook/src/facility/facility_details_page_uc.dart' as _i4;
import 'package:wonder_widgetbook/src/facility/facility_fields_editors_uc.dart' as _i5;
import 'package:wonder_widgetbook/src/platform/chip_uc.dart' as _i6;
import 'package:wonder_widgetbook/src/user/user_widgets_uc.dart' as _i7;

List<_i1.WidgetbookNode> getDirectories() {
  return [
    _i1.WidgetbookCategory(
      name: 'Facility',
      children: [
        _i1.WidgetbookLeafComponent(
          name: 'FacilityCard',
          useCase: _i1.WidgetbookUseCase(
            name: 'default',
            builder: _i3.facilityCard,
          ),
        ),
        _i1.WidgetbookComponent(
          name: 'FacilityDetailsPage',
          useCases: [
            _i1.WidgetbookUseCase(
              name: 'Edit',
              builder: _i4.editFacility,
            ),
            _i1.WidgetbookUseCase(
              name: 'New',
              builder: _i4.newFacility,
            ),
          ],
        ),
        _i1.WidgetbookCategory(
          name: 'Editors',
          children: [
            _i1.WidgetbookLeafComponent(
              name: 'FacilityNumberTextBox',
              useCase: _i1.WidgetbookUseCase(
                name: 'number',
                builder: _i5.number,
              ),
            ),
            _i1.WidgetbookLeafComponent(
              name: 'FacilityRoomCountDropdown',
              useCase: _i1.WidgetbookUseCase(
                name: '# Rooms',
                builder: _i5.roomCount,
              ),
            ),
            _i1.WidgetbookLeafComponent(
              name: 'FacilityStatusDropdown',
              useCase: _i1.WidgetbookUseCase(
                name: 'Status',
                builder: _i5.facilityStatus,
              ),
            ),
            _i1.WidgetbookLeafComponent(
              name: 'FacilitySubtypeDropdown',
              useCase: _i1.WidgetbookUseCase(
                name: 'Subtype',
                builder: _i5.subtype,
              ),
            ),
            _i1.WidgetbookLeafComponent(
              name: 'FacilityTypeDropdown',
              useCase: _i1.WidgetbookUseCase(
                name: 'Type',
                builder: _i5.type,
              ),
            ),
            _i1.WidgetbookLeafComponent(
              name: 'UsersDropdownConsumer',
              useCase: _i1.WidgetbookUseCase(
                name: 'Owner',
                builder: _i5.owner,
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
                builder: _i6.defaultChip,
              ),
            )
          ],
        )
      ],
    ),
    _i1.WidgetbookCategory(
      name: 'User',
      children: [
        _i1.WidgetbookLeafComponent(
          name: 'All',
          useCase: _i1.WidgetbookUseCase(
            name: 'all',
            builder: _i7.all,
          ),
        ),
        _i1.WidgetbookComponent(
          name: 'InitialsAvatar',
          useCases: [
            _i1.WidgetbookUseCase(
              name: 'width = 25',
              builder: _i7.initialsAvatar25,
            ),
            _i1.WidgetbookUseCase(
              name: 'width = 50',
              builder: _i7.initialsAvatar50,
            ),
          ],
        ),
        _i1.WidgetbookComponent(
          name: 'UserAvatar',
          useCases: [
            _i1.WidgetbookUseCase(
              name: 'default',
              builder: _i7.userAvatar,
            ),
            _i1.WidgetbookUseCase(
              name: 'no pic',
              builder: _i7.userAvatarNoPic,
            ),
            _i1.WidgetbookUseCase(
              name: 'no user',
              builder: _i7.userAvatarNoUser,
            ),
            _i1.WidgetbookUseCase(
              name: 'size = 25',
              builder: _i7.userAvatar25,
            ),
            _i1.WidgetbookUseCase(
              name: 'size = 50',
              builder: _i7.userAvatar50,
            ),
          ],
        ),
        _i1.WidgetbookComponent(
          name: 'UserChip',
          useCases: [
            _i1.WidgetbookUseCase(
              name: 'default',
              builder: _i7.userChip,
            ),
            _i1.WidgetbookUseCase(
              name: 'no pic',
              builder: _i7.userChipNoPic,
            ),
            _i1.WidgetbookUseCase(
              name: 'no user',
              builder: _i7.userChipNoUser,
            ),
            _i1.WidgetbookUseCase(
              name: 'overflow',
              builder: _i7.userChipOverflow,
            ),
          ],
        ),
        _i1.WidgetbookComponent(
          name: 'UsersDropdownConsumer',
          useCases: [
            _i1.WidgetbookUseCase(
              name: 'default',
              builder: _i7.usersDropdown,
            ),
            _i1.WidgetbookUseCase(
              name: 'no pic',
              builder: _i7.usersDropdownNoPic,
            ),
            _i1.WidgetbookUseCase(
              name: 'no user',
              builder: _i7.usersDropdownNoUser,
            ),
            _i1.WidgetbookUseCase(
              name: 'overflow',
              builder: _i7.usersDropdownOverflow,
            ),
          ],
        ),
      ],
    ),
    _i1.WidgetbookFolder(
      name: 'debug',
      children: [
        _i1.WidgetbookComponent(
          name: 'UnboundedWidth',
          useCases: [
            _i1.WidgetbookUseCase(
              name: 'not_working',
              builder: _i8.notWorking,
            ),
            _i1.WidgetbookUseCase(
              name: 'unbounded_width',
              builder: _i8.unboundedWidth,
            ),
          ],
        )
      ],
    ),
  ];
}
