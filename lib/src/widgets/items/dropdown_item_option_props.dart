import 'dart:ui';

import '../../data/item.dart';
import '../../resources/colors.dart';
import '../platform/dropdown.dart';

class DropdownItemOptionProps<T extends Item> extends DropdownOptionProps<T> {
  DropdownItemOptionProps({required super.value, Color? color, super.avatar})
      : super(
          title: value.title,
          color: color ?? getItemColor(value),
        );
}
