import 'package:flutter/material.dart' hide Chip;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/user_item.dart';
import '../../../providers/users_provider.dart';
import '../../platform/dropdown.dart';
import 'user_chip.dart';

class UsersDropdownConsumer extends ConsumerWidget {
  final String? value;
  final ValueChanged<String?>? onChanged;
  final FormFieldValidator<String>? validator;

  const UsersDropdownConsumer({
    this.value,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userListProvider);
    return Dropdown<String>(
      value: value,
      optionsProps: _getOptionsProps(users),
      optionBuilder: _optionBuilder,
      selectedBuilder: _selectedBuilder,
      onChanged: onChanged,
      validator: validator,
    );
  }

  List<OptionProps<String>> _getOptionsProps(
    List<UserItem> users,
  ) =>
      users.map(OptionProps.fromItem).toList();

  Widget _optionBuilder(
    OptionProps<dynamic> option,
    TextStyle? style,
    BuildContext _,
  ) {
    return UserChip(
      item: option.data,
      labelStyle: style,
    );
  }

  Widget _selectedBuilder(
    OptionProps<dynamic> option,
    TextStyle? style,
    BuildContext _,
  ) {
    return UserChip(
      item: option.data,
      labelStyle: style,
    );
  }

  Widget emptySelectedBuilder(
    OptionProps option,
    TextStyle? style,
    BuildContext _,
  ) {
    return UserChip(
      item: option.data,
      labelStyle: style,
    );
  }
}
