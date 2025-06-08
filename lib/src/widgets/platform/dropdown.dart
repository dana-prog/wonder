import 'package:dropdown_search/dropdown_search.dart' as ds;
import 'package:flutter/material.dart' hide Chip;
import 'package:wonder/src/resources/labels.dart';

import '../../utils/color_utils.dart';

class Dropdown<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedItem;
  final List<DropdownOptionProps<T>> options;
  final DropdownOptionProps<T>? selectedOption;
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
        options = options ?? items!.map((item) => DropdownOptionProps(value: item)).toList(),
        selectedOption = (selectedItem == null)
            ? null
            : options!.firstWhere((option) => option.value == selectedItem);

  @override
  Widget build(BuildContext context) {
    return ds.DropdownSearch<T?>(
      // decoratorProps: ds.DropDownDecoratorProps(
      //   // set to zeo content padding since non zero content padding displays a small white border around the colored dropdown background
      //   // decoration: InputDecoration(border: Colors.red),
      //   // decoration: InputDecoration(fillColor: Colors.red, contentPadding: EdgeInsets.zero),
      //   // set the text style
      //   baseStyle: style,
      // ),
      selectedItem: selectedOption?.value,
      items: (String filter, ds.LoadProps? loadProps) {
        // TODO: implement filtering logic if needed
        return items;
      },
      onChanged: onChanged,
      compareFn: (item1, item2) => item1 == item2,
      dropdownBuilder: buildSelectedItem,
      itemAsString: (item) => item?.toString() ?? 'itemAsString called with null',
      popupProps: ds.PopupProps.menu(
        itemBuilder: (
          BuildContext context,
          T? item,
          bool isDisabled,
          bool isSelected,
        ) {
          return ListTile(
            // enabled: !_isDisabled(item),
            title: buildSelectedItem(context, item),
            // selected: !widget.popupProps.showSelectedItems ? false : _isSelectedItem(item),
            // onTap: _isDisabled(item) ? null : () => _handleSelectedItem(item),
          );
        },
      ),
      suffixProps: ds.DropdownSuffixProps(
        clearButtonProps: ds.ClearButtonProps(isVisible: false),
        dropdownButtonProps: ds.DropdownButtonProps(isVisible: false),
      ),
      // autoValidateMode: autoValidateMode,
      // mode: mode ?? ds.Mode.form,
      // popupProps: ds.PopupProps.menu(showSearchBox: true),
      // itemAsString: itemAsString,
    );
  }

  DropdownOptionProps<T>? getOption(T? item) {
    if (item == null) return null;
    return options.firstWhere((option) => option.value == item);
  }

  Widget buildPopupItem(T item) {
    return ListTile(
      // enabled: !_isDisabled(item),
      title: Text(selectedOption?.title ?? Labels.selectOption),
      // selected: !widget.popupProps.showSelectedItems ? false : _isSelectedItem(item),
      // onTap: _isDisabled(item) ? null : () => _handleSelectedItem(item),
    );
  }

  Widget buildOption(BuildContext context, DropdownOptionProps<T>? option) {
    return option?.avatar != null
        ? Row(
            children: [
              Padding(
                // TODO: remove hard coded value
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                child: option!.avatar!,
              ),
              Align(child: Text(option.title, style: applyOnColor(style, option.color))),
            ],
          )
        : Text(
            option?.title ?? Labels.selectOption,
            style: applyOnColor(style, option?.color),
          );
  }

  Widget buildSelectedItem(BuildContext context, T? item) {
    return Container(
      // occupy the full width of the dropdown
      width: double.infinity,
      color: getOption(item)?.color ?? Colors.transparent,
      padding: EdgeInsets.all(0),
      height: itemHeight ?? kMinInteractiveDimension,
      alignment: Alignment.center,
      child: buildOption(context, getOption(item)),
    );
  }
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
