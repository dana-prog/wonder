import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchListValuesDropdownConsumer extends ConsumerWidget {
  final List<String> items;
  final String? selectedItem;
  final ValueChanged<String?>? onChanged;

  const SearchListValuesDropdownConsumer({
    required this.items,
    this.selectedItem,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownButton<String>(
      value: selectedItem,
      hint: Text('Select an item'),
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
