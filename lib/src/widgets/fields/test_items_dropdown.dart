import 'package:flutter/material.dart';
import 'package:wonder/src/data/user_item.dart';
import 'package:wonder/src/providers/users_provider.dart';

import '../async/async_value_widget.dart';
import '../media/app_image.dart';

class TestItemsDropdown extends StatelessWidget {
  final String? value;
  final InputDecoration? decoration;
  final ValueChanged<String?>? onChanged;
  final FormFieldValidator<String>? validator;

  const TestItemsDropdown({
    this.value,
    this.decoration,
    this.onChanged,
    this.validator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AsyncValueProviderWidget<List<UserItem>>(
      provider: usersProvider,
      dataBuilder: (values, _, __) {
        return DropdownButtonFormField<String>(
          value: value,
          decoration: decoration,
          // items: getSimpleMenuItems(),
          items: getUsersMenuItems(values),
          onChanged: onChanged,
          validator: validator,
          isExpanded: true,
        );
      },
    );
  }

  List<DropdownMenuItem<String>> getSimpleMenuItems() {
    return ['one', 'two', 'three']
        .map((item) => DropdownMenuItem<String>(
              value: item,
              child: SizedBox(
                  child: Row(
                children: [
                  Flexible(
                      child: Text(
                    item,
                    overflow: TextOverflow.ellipsis,
                  )),
                ],
              )),
            ))
        .toList();
  }

  List<DropdownMenuItem<String>> getUsersMenuItems(List<UserItem> items) {
    final radius = 16.0;

    return items
        .sublist(0, 2)
        .map((item) => DropdownMenuItem<String>(
              value: item.id,
              child: SizedBox(
                  child: Row(
                children: [
                  SizedBox(
                      width: radius * 2,
                      child: ClipOval(
                        child: AppImage(item.picture),
                      )),
                  const SizedBox(width: 8),
                  Flexible(
                      child: Text(
                    item.title,
                    overflow: TextOverflow.ellipsis,
                  )),
                ],
              )),
            ))
        .toList();
  }
}
