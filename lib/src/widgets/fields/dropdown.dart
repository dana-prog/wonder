import 'package:flutter/material.dart' hide Chip;
import 'package:wonder/src/widgets/fields/chip.dart';

import '../../data/item.dart';
import '../../resources/labels.dart';

typedef OptionBuilder = Widget Function(OptionProps<dynamic> option, BuildContext context);

const _itemHeight = kMinInteractiveDimension;

class Dropdown<T> extends StatelessWidget {
  final List<OptionProps<T>> optionsProps;
  final T? value;
  final Widget Function(OptionProps<T> option, BuildContext context)? optionBuilder;
  final String? label;
  final ValueChanged<T?>? onChanged;
  final FormFieldValidator<T>? validator;

  const Dropdown({
    required this.optionsProps,
    this.value,
    this.optionBuilder,
    this.label,
    this.onChanged,
    this.validator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (label != null) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label!, style: Theme.of(context).inputDecorationTheme.labelStyle),
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
          optionsProps.map((option) => Center(child: buildOption(option, context))).toList(),
      onChanged: onChanged,
      itemHeight: _itemHeight,
      // validator: validator,
      isExpanded: true,
    );
  }

  DropdownMenuItem<T> getMenuItem(OptionProps<T> option, BuildContext context) {
    return DropdownMenuItem<T>(
      value: option.value,
      child: Container(
        height: _itemHeight,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: buildOption(option, context),
      ),
    );
  }

  Widget buildOption(OptionProps<T> option, BuildContext context) {
    if (optionBuilder != null) {
      return optionBuilder!(option, context);
    } else {
      return OptionChip(option);
    }
  }
}

class OptionProps<T> {
  final T? value;
  final String title;
  final Color? color;
  final dynamic data;

  const OptionProps({required this.value, required this.title, this.color, this.data});

  static OptionProps<String> fromItem(Item item) {
    return OptionProps<String>(
      value: item.id,
      title: item.title,
      color: item.color,
      data: item,
    );
  }
}

class OptionChip extends StatelessWidget {
  final OptionProps option;

  const OptionChip(this.option);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: option.title,
      backgroundColor: option.color,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}

class EmptyOptionProps extends OptionProps<String> {
  EmptyOptionProps(String typeName)
      : super(
          value: null,
          title: Labels.noItem(typeName),
          color: Colors.transparent,
        );
}
