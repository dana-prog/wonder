import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/lists_of_values_provider.dart';
import '../../platform/dropdown.dart';

class ListValuesDropdownConsumer extends ConsumerWidget {
  final String listType;
  final String? value;
  final TextStyle? style;
  final ValueChanged<String?>? onChanged;
  final FormFieldValidator<String>? validator;

  const ListValuesDropdownConsumer({
    super.key,
    required this.listType,
    this.style,
    this.value,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listValues = ref.watch(listValuesProvider(listType));
    return Dropdown(
      value: value,
      optionsProps: listValues.map(OptionProps.fromItem).toList(),
      style: style,
      onChanged: onChanged,
      validator: validator,
    );
  }
}
