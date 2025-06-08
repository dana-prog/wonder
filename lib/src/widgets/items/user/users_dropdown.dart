import 'package:flutter/material.dart' hide Chip;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/user_item.dart';
import '../../../providers/users_provider.dart';
import '../../platform/dropdown.dart';
import '../dropdown_item_option_props.dart';
import 'user_avatar.dart';

class UsersDropdownConsumer extends ConsumerWidget {
  final String? selectedId;
  final TextStyle? style;
  final ValueChanged<String?>? onChanged;
  // final double? itemHeight;
  // final FormFieldValidator<String>? validator;

  const UsersDropdownConsumer({
    this.selectedId,
    this.style,
    this.onChanged,
    // this.itemHeight,
    // this.validator,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userListProvider);
    return Dropdown<UserItem>(
      selectedItem: users.where((user) => user.id == selectedId).firstOrNull,
      options: users.map((user) => DropdownUserOptionProps(value: user)).toList(),
      style: style,
    );
  }
}

class DropdownUserOptionProps extends DropdownItemOptionProps<UserItem> {
  DropdownUserOptionProps({required super.value})
      : super(
          avatar: UserAvatar(item: value),
          color: Colors.grey.shade200,
        );
}
