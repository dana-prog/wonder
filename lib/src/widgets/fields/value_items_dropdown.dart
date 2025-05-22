import 'package:flutter/material.dart';
import 'package:wonder/src/data/list_value_item.dart';
import 'package:wonder/src/widgets/async/async_value_widget.dart';

import '../../providers/lists_of_values_provider.dart';
import '../../resources/value_item_icons.dart';

class ValueItemsDropdown extends StatelessWidget {
  final ValueItemType type;
  final String? value;
  final InputDecoration? decoration;
  final ValueChanged<String?>? onChanged;
  final FormFieldValidator<String>? validator;

  const ValueItemsDropdown({
    required this.type,
    this.value,
    this.decoration,
    this.onChanged,
    this.validator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AsyncValueProviderWidget<List<ListValueItem>>(
      provider: listOfValuesProvider(type),
      dataBuilder: (values, _, __) {
        return DropdownButtonFormField<String>(
          value: value,
          decoration: decoration,
          items: values.map(getMenuItem).toList(),
          onChanged: onChanged,
          validator: validator,
          isExpanded: true,
        );
      },
    );
  }

  DropdownMenuItem<String> getMenuItem(ListValueItem value) {
    final widgets = <Widget>[];
    final icon = ValueItemIcons.getIcon(value);
    if (icon != null) {
      widgets.add(Icon(icon, size: 16));
      widgets.add(const SizedBox(width: 16));
    }

    return DropdownMenuItem<String>(
      value: value.id,
      child: Row(
        children: [
          ...widgets,
          Text(value.title),
        ],
      ),
    );
  }
}
