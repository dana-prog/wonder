import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/lists_of_values_provider.dart';
import 'dropdown.dart';

class ListValuesDropdownConsumer extends ConsumerWidget {
  final String listType;
  final String? label;
  final String? value;
  final ValueChanged<String?>? onChanged;
  final FormFieldValidator<String>? validator;

  const ListValuesDropdownConsumer({
    super.key,
    required this.listType,
    this.label,
    this.value,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listValues = ref.watch(listValuesProvider(listType));
    return Dropdown(
      labelText: label,
      value: value,
      optionsProps: listValues.map(ItemOptionProps.new).toList(),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
