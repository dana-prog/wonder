import 'package:flutter/material.dart';
import 'package:wonder/src/widgets/items/list_value/list_values_dropdown.dart';

import '../../../../resources/colors.dart';
import '../../../../resources/labels.dart';
import '../../../platform/dropdown.dart';
import '../../constants.dart';

class FacilityTypeDropdown extends ListValuesDropdownConsumer {
  const FacilityTypeDropdown({
    super.key,
    super.selectedId,
    super.onChanged,
  }) : super(listType: 'facilityType');
}

class FacilitySubtypeDropdown extends ListValuesDropdownConsumer {
  const FacilitySubtypeDropdown({
    super.key,
    super.selectedId,
    super.onChanged,
  }) : super(listType: 'facilitySubtype');
}

class FacilityStatusDropdown extends ListValuesDropdownConsumer {
  const FacilityStatusDropdown({
    super.key,
    super.selectedId,
    super.onChanged,
  }) : super(listType: 'facilityStatus');
}

final List<DropdownOptionProps<int>> menuItemsProps = roomCountColors.entries
    .map((entry) => DropdownOptionProps<int>(
          value: entry.key,
          title: Labels.facilityRoomCount(entry.key),
          color: entry.value,
        ))
    .toList();

class FacilityRoomCountDropdown extends StatelessWidget {
  final int? value;
  final TextStyle? style;
  final ValueChanged<int?>? onChanged;

  const FacilityRoomCountDropdown({
    this.value,
    this.style,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Dropdown<int>(
      selectedItem: value,
      options: menuItemsProps,
      onChanged: onChanged,
      style: kDefaultDropdownTextStyle.merge(style),
    );
  }
}
