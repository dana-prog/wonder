import 'package:flutter/material.dart';
import 'package:wonder/src/resources/labels.dart';
import 'package:wonder/src/widgets/facility/constants.dart';

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
    // return _innerBuild(items, context);
    return Dropdown<int>(
      value: value,
      label: ItemsLabels.getFieldLabels('facility')['roomCount'],
      optionsProps: menuItemsProps,
      onChanged: onChanged,
    );
  }

// Widget _innerBuild(List<MenuItemProps<int>> items, BuildContext context) {
//   final selectedListValue = roomCount != null
//       ? items.firstWhere(
//           (item) => item.value == roomCount,
//         )
//       : null;
//   return DropdownButtonFormField<T>(
//     value: roomCount,
//     decoration: InputDecoration(
//         filled: true,
//         fillColor: selectedListValue != null ? selectedListValue.color : Colors.transparent,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide.none,
//         )),
//     icon: const SizedBox.shrink(),
//     items: items.map((item) => getMenuItem(item, context)).toList(),
//     onChanged: onChanged,
//     // validator: validator,
//     isExpanded: true,
//   );
// }
}
