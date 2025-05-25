import 'package:flutter/material.dart';
import 'package:wonder/src/data/list_value_item.dart';
import 'package:wonder/src/widgets/async/async_value_widget.dart';

import '../../providers/lists_of_values_provider.dart';

class ValueItemsDropdown extends StatelessWidget {
  final List<ListValueItem> values;
  final String? value;
  final String? labelText;
  final ValueChanged<String?>? onChanged;
  final FormFieldValidator<String>? validator;

  const ValueItemsDropdown({
    required this.values,
    this.value,
    this.labelText,
    this.onChanged,
    this.validator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (labelText != null) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(labelText!, style: Theme.of(context).inputDecorationTheme.labelStyle),
        buildDropdown(context)
      ]);
    } else {
      return buildDropdown(context);
    }
  }

  Widget buildDropdown(BuildContext context) {
    final selectedListValue = values.firstWhere(
      (item) => item.id == value,
    );

    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
          filled: true,
          fillColor: values.isEmpty ? Colors.transparent : selectedListValue.color,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          )),
      icon: const SizedBox.shrink(),
      items: values.map((listValueItem) => getMenuItem(listValueItem, context)).toList(),
      onChanged: onChanged,
      validator: validator,
      isExpanded: true,
    );
  }

  DropdownMenuItem<String> getMenuItem(ListValueItem listValueItem, BuildContext context) {
    return DropdownMenuItem<String>(
      value: listValueItem.id,
      child: Container(
        // TODO: [P2] replace the hard-coded kMinInteractiveDimension with an option to expand to fill the container
        height: kMinInteractiveDimension,
        width: double.infinity,
        color: listValueItem.color,
        child: Text(listValueItem.title,
            textAlign: TextAlign.center,
            style: DefaultTextStyle.of(context).style.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
      ),
    );
  }
}

class ValueItemsDropdownConsumer extends StatelessWidget {
  final ValueItemType type;
  final String? labelText;
  final String? value;
  final ValueChanged<String?>? onChanged;
  final FormFieldValidator<String>? validator;

  const ValueItemsDropdownConsumer({
    super.key,
    this.labelText,
    required this.type,
    this.value,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return AsyncValueProviderWidget<List<ListValueItem>>(
      provider: listOfValuesProvider(type),
      dataBuilder: (values, _, __) => ValueItemsDropdown(
        values: values,
        labelText: labelText,
        value: value,
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
