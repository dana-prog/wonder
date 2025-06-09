import 'package:dropdown_search/dropdown_search.dart' as ds;
import 'package:flutter/material.dart' hide Chip;

import '../../resources/labels.dart';
import '../../theme/app_theme.dart';
import '../../utils/color_utils.dart';

const kDropdownListViewPadding = 8.0;
const kDropdownPopupOptionVPadding = 3.0;

class Dropdown<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedItem;
  final List<DropdownOptionProps<T>> options;
  final TextStyle? style;
  final double? itemHeight;
  final ValueChanged<T?>? onChanged;
  final ds.Mode? mode;
  final AutovalidateMode autoValidateMode;

  Dropdown({
    super.key,
    List<DropdownOptionProps<T>>? options,
    List<T>? items,
    this.selectedItem,
    this.onChanged,
    this.style,
    this.itemHeight,
    this.mode,
    this.autoValidateMode = AutovalidateMode.disabled,
    // this.itemAsString,
    // this.dropdownBuilder,
    // this.suffixProps = const DropdownSuffixProps(),
    // this.clickProps = const ClickProps(),
    // this.enabled = true,
    // this.filterFn,
    // this.onBeforeChange,
    // this.onBeforePopupOpening,
    // PopupProps<T> popupProps = const PopupProps.menu(),
    //form properties
    // this.onSaved,
    // this.validator,
    // DropDownDecoratorProps? decoratorProps,
  })  : assert(items != null || options != null, 'Either items or options must be provided.'),
        items = items ?? options!.map((option) => option.value!).toList(),
        options = options ?? items!.map((item) => DropdownOptionProps(value: item)).toList();

  @override
  Widget build(BuildContext context) {
    final selectedOption = getOption(selectedItem);

    return ds.DropdownSearch<T?>(
      decoratorProps: ds.DropDownDecoratorProps(
        decoration: InputDecoration(
          // set to zero content padding since non zero content padding displays a small white border around the colored dropdown background
          contentPadding: EdgeInsets.all(0),
          // remove the border for the input decoration
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        // set the text style
        // baseStyle: style,
      ),
      selectedItem: selectedOption?.value,
      items: (_, __) => items,
      onChanged: onChanged,
      compareFn: (item1, item2) => item1 == item2,
      dropdownBuilder: (_, T? item) => _DropdownOption(
        option: getOption(item),
        style: style,
      ),
      itemAsString: (item) => item?.toString() ?? 'itemAsString called with null',
      popupProps: ds.PopupProps.menu(
        fit: FlexFit.loose,
        listViewProps: ds.ListViewProps(padding: EdgeInsets.all(kDropdownListViewPadding)),
        itemBuilder: (BuildContext context, T? item, bool isDisabled, bool isSelected) =>
            _DropdownPopupOption(
          option: getOption(item),
          isDisabled: isDisabled,
          isSelected: isSelected,
          style: style,
        ),
      ),
      suffixProps: ds.DropdownSuffixProps(
        clearButtonProps: ds.ClearButtonProps(isVisible: false),
        dropdownButtonProps: ds.DropdownButtonProps(isVisible: false),
      ),
    );
  }

  DropdownOptionProps<T>? getOption(T? item) =>
      item != null ? options.firstWhere((option) => option.value == item) : null;
}

class DropdownOptionProps<T> {
  final T value;
  final String title;
  final Color? color;
  final Widget? avatar;
  final dynamic data;

  DropdownOptionProps({
    required this.value,
    String? title,
    this.color,
    this.avatar,
    this.data,
  }) : title = title ?? value?.toString() ?? '';
}

class _DropdownOption<T> extends StatelessWidget {
  final DropdownOptionProps<T>? option;
  final double? height;
  final TextStyle? style;
  final EdgeInsetsGeometry? padding;

  const _DropdownOption({
    required this.option,
    this.height,
    this.style,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = option?.color ?? Theme.of(context).colorScheme.surface;
    return Padding(
      padding: EdgeInsets.all(3),
      child: Container(
        height: height ?? kMinInteractiveDimension,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(defaultBorderRadius),
        ),
        child: contentBuilder(context, backgroundColor),
      ),
    );
  }

  Widget contentBuilder(BuildContext context, Color backgroundColor) {
    final textWidget = Align(
      // setting widthFactor to 1.0 since the default behavior is that the Align widget takes up all available space in that axis
      widthFactor: 1.0,
      child: Text(
        option?.title ?? Labels.selectOption,
        style: applyOnColor(style, backgroundColor),
        overflow: TextOverflow.ellipsis,
      ),
    );

    if (option?.avatar == null) {
      return textWidget;
    }

    return Row(
      children: [
        Padding(
          // TODO: remove hard coded value
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: option!.avatar!,
        ),
        Expanded(child: textWidget),
      ],
    );
  }
}

class _DropdownPopupOption<T> extends StatelessWidget {
  final DropdownOptionProps<T>? option;
  final bool isDisabled;
  final bool isSelected;
  final double? height;
  final TextStyle? style;

  const _DropdownPopupOption({
    required this.option,
    required this.isDisabled,
    required this.isSelected,
    this.height,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return _DropdownOption<T>(
      option: option,
      style: style,
      padding: EdgeInsets.symmetric(vertical: kDropdownPopupOptionVPadding),
    );
  }
}
