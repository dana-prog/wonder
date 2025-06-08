import 'package:flutter/material.dart';

import '../../../../resources/colors.dart';
import '../../../../resources/labels.dart';
import '../../../platform/dropdown.dart';
import '../../constants.dart';

final List<DropdownOptionProps<int>> menuItemsProps = roomCountColors.entries
    .map((entry) => DropdownOptionProps<int>(
          value: entry.key,
          title: Labels.facilityRoomCount(entry.key),
          color: entry.value,
        ))
    .toList();

class RoomCountDropdown extends StatelessWidget {
  final int? value;
  final TextStyle? style;
  final ValueChanged<int?>? onChanged;

  const RoomCountDropdown({
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
