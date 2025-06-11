import 'package:dropdown_search/dropdown_search.dart' as ds;
import 'package:flutter/material.dart' hide Chip;

import '../../resources/labels.dart';
import '../../theme/app_theme.dart';
import '../../utils/color_utils.dart';

const kDropdownListViewPadding = 8.0;
const kDropdownPopupOptionVPadding = 3.0;
const _defaultAlignment = MainAxisAlignment.center;
final _defaultShowSearchBox = false;

class Dropdown<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedItem;
  final List<DropdownOptionProps<T>> options;
  final TextStyle? style;
  final double? itemHeight;
  final ValueChanged<T?>? onChanged;
  final ds.Mode? mode;
  final AutovalidateMode autoValidateMode;
  final MainAxisAlignment? selectedItemAlignment;
  final MainAxisAlignment? popupItemAlignment;
  final bool? showSearchBox;

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
    this.selectedItemAlignment,
    this.popupItemAlignment,
    this.showSearchBox,
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
      ),
      selectedItem: selectedOption?.value,
      items: (_, __) => items,
      onChanged: onChanged,
      compareFn: (item1, item2) => item1 == item2,
      dropdownBuilder: (_, T? item) => _DropdownOption(
        option: getOption(item),
        style: style,
        alignment: selectedItemAlignment,
      ),
      itemAsString: (item) => item?.toString() ?? 'itemAsString called with null',
      filterFn: (T? item, String? filter) {
        if (filter == null || filter.isEmpty) return true;
        final option = getOption(item);
        return option?.title.toLowerCase().contains(filter.toLowerCase()) ?? false;
      },
      popupProps: ds.PopupProps.menu(
        fit: FlexFit.loose,
        showSearchBox: showSearchBox ?? _defaultShowSearchBox,
        searchFieldProps: ds.TextFieldProps(
          autofocus: true,
          decoration: InputDecoration(
            hintText: Labels.searchHint,
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          ),
        ),
        listViewProps: ds.ListViewProps(padding: EdgeInsets.all(kDropdownListViewPadding)),
        itemBuilder: (BuildContext context, T? item, bool isDisabled, bool isSelected) =>
            _DropdownPopupOption(
          option: getOption(item),
          isDisabled: isDisabled,
          isSelected: isSelected,
          style: style,
          alignment: popupItemAlignment ?? selectedItemAlignment,
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
  final MainAxisAlignment? alignment;

  const _DropdownOption({
    required this.option,
    this.height,
    this.style,
    this.padding,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = option?.color ?? Theme.of(context).colorScheme.surface;
    return Padding(
      padding: EdgeInsets.all(3),
      child: Container(
        height: height ?? kMinInteractiveDimension,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(defaultBorderRadius),
        ),
        child: contentBuilder(context, backgroundColor),
      ),
    );
  }

  Widget contentBuilder(BuildContext context, Color backgroundColor) {
    final textWidget = Text(
      option?.title ?? Labels.selectOption,
      style: applyOnColor(style, backgroundColor),
      overflow: TextOverflow.ellipsis,
    );

    return Row(
      mainAxisAlignment: alignment ?? _defaultAlignment,
      children: [
        option?.avatar != null
            ? Padding(
                // TODO: remove hard coded value
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: option!.avatar!,
              )
            : SizedBox.shrink(),
        // textWidget,
        Flexible(child: textWidget),
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
  final MainAxisAlignment? alignment;

  const _DropdownPopupOption({
    required this.option,
    required this.isDisabled,
    required this.isSelected,
    this.height,
    this.style,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return _DropdownOption<T>(
      option: option,
      style: style,
      padding: EdgeInsets.symmetric(vertical: kDropdownPopupOptionVPadding),
      alignment: alignment,
    );
  }
}
