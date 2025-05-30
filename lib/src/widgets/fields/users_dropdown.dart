import 'package:flutter/material.dart' hide Chip;
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
      optionsProps: _getOptionsProps(users),
      optionBuilder: _optionBuilder,
      selectedBuilder: _selectedBuilder,
      onChanged: onChanged,
      validator: validator,
    );
  }

  List<OptionProps<String>> _getOptionsProps(List<UserItem> users) {
    final options = <OptionProps<String>>[];
    options.add(EmptyOptionProps('user'));
    for (final user in users) {
      options.add(OptionProps.fromItem(user));
    }

    return options;
  }

  Widget _optionBuilder(OptionProps<String> option, BuildContext _) {
    return UserChip(user: option.data);
  }

  Widget _selectedBuilder(OptionProps<String> option, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 1,
        ),
      ),
      child: UserChip(
        user: option.data,
        // backgroundColor: Colors.grey.shade400,
        padding: defaultOptionChipPadding.copyWith(left: 8, right: 8),
        labelStyle: TextStyle(
            color: Theme.of(context).textTheme.labelSmall?.color, fontWeight: FontWeight.normal),
      ),
    );
  }
}
