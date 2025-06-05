import 'package:flutter/material.dart' hide Chip;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/user_item.dart';
import '../../../providers/users_provider.dart';
import '../../platform/dropdown.dart';
import '../dropdown_item_option_props.dart';
import 'user_avatar.dart';

class UsersDropdownConsumer extends ConsumerWidget {
  final String? value;
  final TextStyle? style;
  final double? itemHeight;
  final ValueChanged<String?>? onChanged;
  final FormFieldValidator<String>? validator;

  const UsersDropdownConsumer({
    this.value,
    this.style,
    this.itemHeight,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userListProvider);
    return Dropdown<String>(
      value: value,
      optionsProps: users.map(DropdownUserOptionProps.new).toList(),
      style: style,
      itemHeight: itemHeight,
    );
  }
}

class DropdownUserOptionProps extends DropdownItemOptionProps {
  DropdownUserOptionProps(UserItem super.item)
      : super(
          avatar: UserAvatar(item: item),
          color: Colors.grey.shade200,
        );
}
