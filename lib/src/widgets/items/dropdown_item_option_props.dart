import 'dart:ui';

import '../../data/item.dart';
import '../../resources/colors.dart';
import '../platform/dropdown.dart';

class DropdownItemOptionProps extends DropdownOptionProps<String> {
  DropdownItemOptionProps(Item item, {Color? color, super.avatar})
      : super(
          value: item.id,
          title: item.title,
          color: color ?? getItemColor(item),
          data: item,
        );
}
