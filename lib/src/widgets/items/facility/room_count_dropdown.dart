import 'package:flutter/material.dart';

import '../../../resources/colors.dart';
import '../../../resources/labels.dart';
import '../../platform/dropdown.dart';
import '../../platform/field_label.dart';

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
  final double? itemHeight;
  final ValueChanged<int?>? onChanged;

  const RoomCountDropdown({
    this.value,
    this.style,
    this.itemHeight,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FieldLabel(
      label: ItemsLabels.getFieldLabels('facility')['roomCount']!,
      child: Dropdown<int>(
        value: value,
        itemHeight: itemHeight,
        optionsProps: menuItemsProps,
        onChanged: onChanged,
        style: style,
      ),
    );
  }
}
