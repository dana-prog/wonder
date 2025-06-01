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
  final OptionProps<T>? emptyOptionProps;
  final Widget Function(OptionProps<T> option, BuildContext context)? optionBuilder;
  final ValueChanged<T?>? onChanged;
  final FormFieldValidator<T>? validator;
  final Widget Function(OptionProps<T> option, BuildContext context)? selectedBuilder;

  const Dropdown({
    required this.optionsProps,
    this.value,
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

  List<Widget> buildSelectedItems(BuildContext context) {
    return _actualOptionsProps
        .map((option) => Center(
              // TODO: remove column?
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
      color: item.color,
      data: item,
    );
  }
}

final _defaultOptionChipColor = Colors.grey.shade100;

// a chip for displaying an option in a dropdown
class OptionChip extends StatelessWidget {
  final OptionProps option;
  final EdgeInsetsGeometry? padding;

  const OptionChip(this.option, {this.padding});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: option.title,
      backgroundColor: option.color ?? _defaultOptionChipColor,
      padding: padding,
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
