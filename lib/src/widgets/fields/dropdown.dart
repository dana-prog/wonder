import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wonder/src/data/list_value_item.dart';

import '../../providers/lists_of_values_provider.dart';

class Dropdown<T> extends StatelessWidget {
  final List<OptionProps<T>> optionsProps;
  final T? value;
  final String? labelText;
  final ValueChanged<T?>? onChanged;
  final FormFieldValidator<T>? validator;

  const Dropdown({
    required this.optionsProps,
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
    final selectedListValue = value != null
        ? optionsProps.firstWhere(
            (item) => item.value == value,
          )
        : null;

    return DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(
          filled: true,
          fillColor: selectedListValue != null ? selectedListValue.color : Colors.transparent,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          )),
      icon: const SizedBox.shrink(),
      items: optionsProps.map((optionProps) => getMenuItem(optionProps, context)).toList(),
      selectedItemBuilder: (BuildContext context) =>
          optionsProps.map((optionProps) => getOptionWidget(optionProps, context)).toList(),
      onChanged: onChanged,
      // validator: validator,
      isExpanded: true,
    );
  }

  DropdownMenuItem<T> getMenuItem(OptionProps<T> optionProps, BuildContext context) {
    return DropdownMenuItem<T>(
      value: optionProps.value,
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 6), child: getOptionWidget(optionProps, context)),
    );
  }

  Widget getOptionWidget(OptionProps<T> option, BuildContext context) {
    return Container(
      // TODO: [P2] replace the hard-coded kMinInteractiveDimension with an option to expand to fill the container
      height: kMinInteractiveDimension,
      width: double.infinity,
      decoration: BoxDecoration(
        color: option.color,
        borderRadius: BorderRadius.circular(10),
      ),
      // color: dropdownItem.color,
      child: Center(
        child: Text(option.title,
            textAlign: TextAlign.center,
            style: DefaultTextStyle.of(context).style.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
      ),
    );
  }
}

class ValueItemsDropdownConsumer extends ConsumerWidget {
  final String type;
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
  Widget build(BuildContext context, WidgetRef ref) {
    final values = ref.watch(listValuesProvider(type));
    return Dropdown(
      optionsProps: values.map(OptionProps.fromListValueItem).toList(),
      labelText: labelText,
      value: value,
      onChanged: onChanged,
      validator: validator,
    );
  }
}

class OptionProps<T> {
  final T value;
  final String title;
  final Color? color;

  const OptionProps({
    required this.value,
    required this.title,
    this.color,
  });

  static OptionProps<String> fromListValueItem(ListValueItem item) {
    return OptionProps<String>(
      value: item.id,
      title: item.title,
      color: item.color,
    );
  }
}
