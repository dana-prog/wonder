import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wonder/src/widgets/async/async_value_widget.dart';

import '../../data/user_item.dart';
import '../../providers/users_provider.dart';
import '../media/app_image.dart';

Map<String, String> cities = <String, String>{
  'New York': 'NYC',
  'Los Angeles': 'LA',
  'San Francisco': 'SF',
  'Chicago': 'CH',
  'Miami': 'MI',
};

class UserItemsDropdown extends StatelessWidget {
  final String? value;
  final InputDecoration? decoration;
  final List<DropdownMenuItem<String>>? items;
  final ValueChanged<String?>? onChanged;
  final FormFieldValidator<String>? validator;

  const UserItemsDropdown({
    this.value,
    this.decoration,
    this.items,
    this.onChanged,
    this.validator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AsyncValueProviderWidget2<List<UserItem>, UserItem?>(
      provider1: usersProvider,
      provider2: value != null
          ? userProvider(value!)
          : FutureProvider((_) async {
              return null;
            }),
      dataBuilder: (users, selectedUser, _, __) {
        return DropdownButtonFormField<String>(
          isExpanded: true,
          value: value,
          items: users.map(getMenuItem).toList(),
          decoration: decoration,
          onChanged: onChanged,
          validator: validator,
        );
      },
    );
  }

  DropdownMenuItem<String> getMenuItem(UserItem item) {
    final radius = 12.0;

    return DropdownMenuItem<String>(
      value: item.id,
      child: SizedBox(
          child: Row(
        children: [
          SizedBox(
              width: radius * 2,
              child: ClipOval(
                child: AppImage(item.picture, height: radius * 2, width: radius * 2),
              )),
          const SizedBox(width: 8),
          Flexible(
              child: Text(
            item.title,
            overflow: TextOverflow.ellipsis,
          )),
        ],
      )),
    );
  }
}
