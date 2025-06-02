import 'package:flutter/material.dart' hide Chip;
import 'package:wonder/src/resources/colors.dart';
import 'package:wonder/src/widgets/platform/chip.dart';

import '../../data/item.dart';
import '../../resources/labels.dart';

typedef OptionBuilder = Widget Function(
    OptionProps<dynamic> option, TextStyle? style, BuildContext context);

Widget _defaultOptionBuilder(OptionProps option, TextStyle? style, BuildContext context) =>
    OptionChip(option: option, style: style);

class Dropdown<T> extends StatelessWidget {
  final List<OptionProps<T>> optionsProps;
  final T? value;
  final TextStyle? style;
  final OptionProps<T>? emptyOptionProps;
  final OptionBuilder? optionBuilder;
  final ValueChanged<T?>? onChanged;
  final FormFieldValidator<T>? validator;
  final OptionBuilder? selectedBuilder;

  const Dropdown({
    required this.optionsProps,
    this.value,
    this.style,
    this.emptyOptionProps,
    this.optionBuilder,
    this.selectedBuilder,
    this.onChanged,
    this.validator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      alignment: Alignment.topCenter,
      isDense: false,
      value: value,
      style: style,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(0),
        fillColor: Colors.transparent,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        // the following prop enables setting a small height to the item
        isCollapsed: true,
      ),
      icon: const SizedBox.shrink(),
      items: buildMenuItems(context),
      selectedItemBuilder: buildSelectedItems,
      onChanged: onChanged,
      isExpanded: true,
    );
  }

  List<DropdownMenuItem<T>> buildMenuItems(BuildContext context) {
    return _actualOptionsProps
        .map(
          (optionProps) => DropdownMenuItem<T>(
            value: optionProps.value,
            child: buildOption(optionProps, context),
          ),
        )
        .toList();
  }

  Widget buildOption(OptionProps<T> option, BuildContext context) =>
      (optionBuilder ?? _defaultOptionBuilder)(option, style, context);

  List<Widget> buildSelectedItems(BuildContext context) {
    return _actualOptionsProps
        .map((option) => Center(child: buildOption(option, context)))
        .toList();
  }

  List<OptionProps<T>> get _actualOptionsProps => [
        emptyOptionProps ?? OptionProps<T>(value: null, title: Labels.selectOption),
        ...optionsProps,
      ];
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
      color: getItemColor(item),
      data: item,
    );
  }
}

// a chip for displaying an option in a dropdown
class OptionChip extends StatelessWidget {
  final OptionProps option;
  final EdgeInsetsGeometry? padding;
  final TextStyle? style;

  const OptionChip({
    required this.option,
    this.padding,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: option.title,
      backgroundColor: option.color,
      padding: padding,
      labelStyle: style,
    );
  }
}

// an empty option for displaying when there are no items in the dropdown
class EmptyOptionProps<T> extends OptionProps<T> {
  EmptyOptionProps({String? title, Color? color})
      : super(
          value: null,
          title: title ?? Labels.selectOption,
        );
}
