import 'package:flutter/material.dart' hide Chip, DropdownMenuItem;
import 'package:wonder/src/utils/color_utils.dart';

import '../../resources/labels.dart';
import 'overrides/material_dropdown.dart';

typedef OptionBuilder = Widget Function(
    DropdownOptionProps<dynamic> option, TextStyle? style, BuildContext context);

class Dropdown<T> extends StatelessWidget {
  final List<DropdownOptionProps<T>> optionsProps;
  final T? value;
  final TextStyle? style;
  final double? itemHeight;
  final DropdownOptionProps<T>? emptyOptionProps;
  final OptionBuilder? optionBuilder;
  final ValueChanged<T?>? onChanged;
  final FormFieldValidator<T>? validator;

  const Dropdown({
    required this.optionsProps,
    this.value,
    this.style,
    this.itemHeight,
    this.emptyOptionProps,
    this.optionBuilder,
    this.onChanged,
    this.validator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialDropdownButtonFormField<T>(
      alignment: Alignment.topCenter,
      isDense: false,
      value: value,
      style: style,
      // TODO: remove hard coded value
      // itemHeight: itemHeight,
      decoration: InputDecoration(
        // contentPadding: const EdgeInsets.all(0),
        border: OutlineInputBorder(borderSide: BorderSide.none),
        // prevent the dropdown from occupying extra space
        isCollapsed: true,
      ),
      // hide the open dropdown arrow icon
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
            child: DropdownOption<T>(
              option: optionProps,
              style: style,
              height: itemHeight,
            ),
          ),
        )
        .toList();
  }

  List<Widget> buildSelectedItems(BuildContext context) {
    return _actualOptionsProps
        .map((option) => Center(
                child: DropdownOption<T>(
              option: option,
              style: style,
              height: itemHeight,
            )))
        .toList();
  }

  List<DropdownOptionProps<T>> get _actualOptionsProps => [
        emptyOptionProps ?? DropdownOptionProps<T>(value: null, title: Labels.selectOption),
        ...optionsProps,
      ];

  DropdownOptionProps<T> get selectedOption {
    return _actualOptionsProps.firstWhere(
      (option) => option.value == value,
      orElse: () =>
          emptyOptionProps ?? DropdownOptionProps<T>(value: null, title: Labels.selectOption),
    );
  }
}

// data for displaying a dropdown option
class DropdownOptionProps<T> {
  final T? value;
  final String title;
  final Color? color;
  final Widget? avatar;
  final dynamic data;

  const DropdownOptionProps({
    required this.value,
    required this.title,
    this.color,
    this.avatar,
    this.data,
  });
}

// an empty option for displaying when there are no items in the dropdown
class EmptyOptionProps<T> extends DropdownOptionProps<T> {
  EmptyOptionProps({String? title, Color? color})
      : super(
          value: null,
          title: title ?? Labels.selectOption,
        );
}

class DropdownOption<T> extends StatelessWidget {
  final DropdownOptionProps<T> option;
  final TextStyle? style;
  final double? height;

  const DropdownOption({
    required this.option,
    this.style,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // occupy the full width of the dropdown
      width: double.infinity,
      height: height ?? kMinInteractiveDimension,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: option.color ?? Colors.transparent,
        // TODO: remove hard coded value
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: option.avatar != null
          ? Row(
              children: [
                Padding(
                  // TODO: remove hard coded value
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  child: option.avatar!,
                ),
                Align(child: Text(option.title, style: applyOnColor(style, option.color))),
              ],
            )
          : Text(option.title, style: applyOnColor(style, option.color)),
    );
  }
}
