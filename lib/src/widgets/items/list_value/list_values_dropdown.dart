import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wonder/src/widgets/items/dropdown_item_option_props.dart';

import '../../../providers/lists_of_values_provider.dart';
import '../../platform/dropdown.dart';

class ListValuesDropdownConsumer extends ConsumerWidget {
  final String listType;
  final String? value;
  final TextStyle? style;
  final double? itemHeight;
  final ValueChanged<String?>? onChanged;
  final FormFieldValidator<String>? validator;

  const ListValuesDropdownConsumer({
    required this.listType,
    this.value,
    this.style,
    this.itemHeight,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listValues = ref.watch(listValuesProvider(listType));
    return Dropdown<String>(
      value: value,
      style: style,
      itemHeight: itemHeight,
      optionsProps: listValues.map(DropdownItemOptionProps.new).toList(),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
