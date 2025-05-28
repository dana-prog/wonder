import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wonder/src/widgets/fields/dropdown.dart';
import 'package:wonder/src/widgets/user/user_chip.dart';

import '../../data/user_item.dart';
import '../../logger.dart';
import '../../providers/users_provider.dart';

class UsersDropdownConsumer extends ConsumerWidget {
  final String? value;
  final String? label;
  final ValueChanged<String?>? onChanged;
  final FormFieldValidator<String>? validator;

  const UsersDropdownConsumer({
    this.value,
    this.label,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userListProvider);
    return Dropdown<String>(
      optionsProps: users.map(ItemOptionProps.new).toList(),
      optionBuilder: buildOption,
      value: value,
      onChanged: onChanged,
      validator: validator,
    );
  }

  Widget buildOption(OptionProps<String> option, BuildContext _) {
    logger.d('[UsersDropdownConsumer] buildOption: $option');
    assert(option is ItemOptionProps<UserItem>, 'Expected ItemOptionProps');
    return UserChip(user: (option as ItemOptionProps<UserItem>).item);
  }
}
