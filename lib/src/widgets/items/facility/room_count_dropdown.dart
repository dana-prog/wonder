import 'package:flutter/material.dart';

import '../../../resources/colors.dart';
import '../../../resources/labels.dart';
import '../../platform/dropdown.dart';
import '../../platform/field_label.dart';

final List<OptionProps<int>> menuItemsProps = roomCountColors.entries
    .map((entry) => OptionProps<int>(
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
    return FieldLabel(
      label: ItemsLabels.getFieldLabels('facility')['roomCount']!,
      child: Dropdown<int>(
        value: value,
        optionsProps: menuItemsProps,
        onChanged: onChanged,
        style: style,
      ),
    );
  }
}
