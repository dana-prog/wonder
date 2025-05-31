import 'package:flutter/material.dart';
import 'package:wonder/src/resources/labels.dart';
import 'package:wonder/src/widgets/facility/constants.dart';
import 'package:wonder/src/widgets/platform/field_label.dart';

import '../fields/dropdown.dart';

final List<OptionProps<int>> menuItemsProps = roomCountColors.entries
    .map((entry) => OptionProps<int>(
          value: entry.key,
          title: Labels.facilityRoomCount(entry.key),
          color: entry.value,
        ))
    .toList();

class RoomCountDropdown extends StatelessWidget {
  final int? value;
  final ValueChanged<int?>? onChanged;

  const RoomCountDropdown({this.value, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return FieldLabel(
      label: ItemsLabels.getFieldLabels('facility')['roomCount']!,
      child: Dropdown<int>(
        value: value,
        optionsProps: menuItemsProps,
        onChanged: onChanged,
      ),
    );
  }
}
