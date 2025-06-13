import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/list_value_item.dart';
import '../../../providers/lists_of_values_provider.dart';
import '../../platform/dropdown.dart';
import '../constants.dart';
import '../dropdown_item_option_props.dart';

class ListValuesDropdownConsumer extends ConsumerWidget {
  final String listType;
  final String? selectedId;
  final TextStyle? style;
  final ValueChanged<ListValueItem?>? onChanged;
  final double? itemHeight;
  final FormFieldValidator<ListValueItem>? validator;

  const ListValuesDropdownConsumer({
    super.key,
    required this.listType,
    this.selectedId,
    this.style,
    this.onChanged,
    this.itemHeight,
    this.validator,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<ListValueItem> listValues = ref.read(listValuesProvider(listType));
    final ListValueItem? selectedItem =
        selectedId != null ? listValues.firstWhere((item) => item.id == selectedId) : null;

    return Dropdown<ListValueItem>(
      onChanged: onChanged,
      selectedItem: selectedItem,
      options: listValues
          .map(
            (ListValueItem listValue) => DropdownItemOptionProps<ListValueItem>(value: listValue),
          )
          .toList(),
      style: kDefaultDropdownTextStyle.merge(style),
      itemHeight: itemHeight,
      validator: validator,
    );
  }
}
