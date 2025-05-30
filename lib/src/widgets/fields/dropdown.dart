import 'package:flutter/material.dart' hide Chip;
import 'package:wonder/src/widgets/fields/chip.dart';

import '../../data/item.dart';
import '../../resources/labels.dart';

const defaultOptionChipPadding = EdgeInsets.symmetric(vertical: 6);

typedef OptionBuilder = Widget Function(OptionProps<dynamic> option, BuildContext context);
Widget _defaultOptionBuilder(OptionProps option, BuildContext context) =>
    OptionChip(option, padding: defaultOptionChipPadding);

class Dropdown<T> extends StatelessWidget {
  final List<OptionProps<T>> optionsProps;
  final T? value;
  final Widget Function(OptionProps<T> option, BuildContext context)? optionBuilder;
  final String? label;
  final ValueChanged<T?>? onChanged;
  final FormFieldValidator<T>? validator;
  final Widget Function(OptionProps<T> option, BuildContext context)? selectedBuilder;

  const Dropdown({
    required this.optionsProps,
    this.value,
    this.optionBuilder,
    this.selectedBuilder,
    this.label,
    this.onChanged,
    this.validator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (label != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 6,
        children: [
          Text(label!, style: Theme.of(context).inputDecorationTheme.labelStyle),
          buildDropdown(context)
        ],
      );
    } else {
      return buildDropdown(context);
    }
  }

  Widget buildDropdown(BuildContext context) {
    return DropdownButtonFormField<T>(
      alignment: Alignment.topCenter,
      isDense: false,
      value: value,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(0),
        fillColor: Colors.transparent,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        isCollapsed: true,
      ),
      icon: const SizedBox.shrink(),
      items: buildMenuItems(optionsProps, context),
      selectedItemBuilder: (BuildContext context) => buildSelectedItems(optionsProps, context),
      onChanged: onChanged,
      isExpanded: true,
    );
  }

  List<DropdownMenuItem<T>> buildMenuItems(List<OptionProps<T>> optionProps, BuildContext context) {
    return optionsProps
        .map(
          (optionProps) => DropdownMenuItem<T>(
            value: optionProps.value,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: buildOption(optionProps, context),
            ),
          ),
        )
        .toList();
  }

  Widget buildOption(OptionProps<T> option, BuildContext context) =>
      (optionBuilder ?? _defaultOptionBuilder)(option, context);

  List<Widget> buildSelectedItems(List<OptionProps<T>> option, BuildContext context) {
    return optionsProps
        .map((option) => Center(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: (selectedBuilder ?? _defaultOptionBuilder)(option, context),
                  ),
                ],
              ),
            ))
        .toList();
  }
}

// data for displaying a dropdown option
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

// a chip for displaying an option in a dropdown
class OptionChip extends StatelessWidget {
  final OptionProps option;
  final EdgeInsetsGeometry? padding;

  const OptionChip(this.option, {this.padding});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: option.title,
      backgroundColor: option.color,
      padding: padding,
    );
  }
}

// an empty option for displaying when there are no items in the dropdown
class EmptyOptionProps extends OptionProps<String> {
  EmptyOptionProps(String typeName)
      : super(
          value: null,
          title: Labels.noItem(typeName),
          color: Colors.transparent,
        );
}
