import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/user_item.dart';
import '../../providers/users_provider.dart';
import '../media/app_image.dart';

class UserItemsDropdown extends StatelessWidget {
  final String? value;
  final List<UserItem> users;
  final ValueChanged<String?>? onChanged;
  final FormFieldValidator<String>? validator;

  const UserItemsDropdown({
    required this.users,
    this.value,
    this.onChanged,
    this.validator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      value: value,
      items: users.map(getMenuItem).toList(),
      onChanged: onChanged,
      validator: validator,
    );
  }

  DropdownMenuItem<String> getMenuItem(UserItem item) {
    // TODO: move radius to a constant
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

class UserItemsDropdownConsumer extends ConsumerWidget {
  final String? value;
  final InputDecoration? decoration;
  final ValueChanged<String?>? onChanged;
  final FormFieldValidator<String>? validator;

  const UserItemsDropdownConsumer({
    this.value,
    this.decoration,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userListProvider);
    return UserItemsDropdown(
      users: users,
      value: value,
      onChanged: onChanged,
      validator: validator,
    );
  }
}
