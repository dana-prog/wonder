import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wonder/src/widgets/facility/facility_details_page.dart';

import '../../data/item.dart';
import '../../providers/items_provider.dart';
import '../async/async_value_widget.dart';

typedef FormBodyBuilder = Widget Function(String itemType, String id);

Map<String, FormBodyBuilder> _formBody = {
  'facility': FacilityDetailsPageConsumer.new,
};

class ItemForm extends StatelessWidget {
  final Item item;
  final FormBodyBuilder formBodyBuilder;

  ItemForm({required this.item})
      : assert(_formBody[item.itemType] != null, 'Unsupported item type: ${item.itemType}'),
        formBodyBuilder = _formBody[item.itemType]!;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        formTitleBuilder(context),
        SizedBox(height: 20),
        formBodyBuilder(item.itemType, item.id),
      ],
    );
  }

  Widget formTitleBuilder(BuildContext context) => Align(
        alignment: Alignment.centerLeft,
        child: Text(
          item.title,
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      );
}

class ItemFormConsumer extends ConsumerWidget {
  final String itemType;
  final String id;

  const ItemFormConsumer({
    required this.itemType,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncItem = ref.watch(itemProvider((itemType, id)));

    return AsyncValueWidget<Item>(
      asyncValue: asyncItem,
      dataBuilder: (item, _) => ItemForm(item: item),
    );
  }
}
