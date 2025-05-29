import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wonder/src/widgets/fields/dropdown.dart';
import 'package:wonder/src/widgets/user/user_chip.dart';

import '../../data/user_item.dart';
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
      value: value,
      label: label,
      optionsProps: getOptionsProps(users),
      optionBuilder: optionBuilder,
      onChanged: onChanged,
      validator: validator,
    );
  }

  List<OptionProps<String>> getOptionsProps(List<UserItem> users) {
    final options = <OptionProps<String>>[];
    options.add(EmptyOptionProps('user'));
    for (final user in users) {
      options.add(OptionProps.fromItem(user));
    }

    return options;
  }

  Widget optionBuilder(OptionProps<String> option, BuildContext _) {
    return UserChip(user: option.data);
  }
}
