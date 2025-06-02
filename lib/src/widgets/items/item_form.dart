import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/item.dart';
import '../../providers/items_provider.dart';
import '../../resources/labels.dart';
import '../async/async_value_widget.dart';
import 'facility/facility_details_page.dart';

class ItemForm extends StatelessWidget {
  final Item? item;
  final String? itemType;

  ItemForm({required this.item, this.itemType})
      : assert(item == null || itemType == null || item.itemType == itemType,
            'item.ItemType should be equal to itemType. item: $item, itemType: $itemType');

  String get resolvedItemType => item?.itemType ?? itemType!;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FormTitleBuilder(title: item?.title ?? Labels.newItem(resolvedItemType)),
        SizedBox(height: 20),
        FormBody(itemType: resolvedItemType, id: item?.id),
      ],
    );
  }
}

class ItemFormConsumer extends ConsumerWidget {
  final String itemType;
  final String? id;

  const ItemFormConsumer({
    required this.itemType,
    this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncItem = id != null ? ref.watch(itemProvider((itemType, id!))) : AsyncValue.data(null);

    return AsyncValueWidget<Item?>(
      asyncValue: asyncItem,
      dataBuilder: (item, _) => ItemForm(item: item, itemType: itemType),
    );
  }
}

class FormTitleBuilder extends StatelessWidget {
  final String title;

  const FormTitleBuilder({required this.title});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}

class FormBody extends StatelessWidget {
  final String itemType;
  final String? id;

  const FormBody({required this.itemType, this.id});

  @override
  Widget build(BuildContext context) {
// TODO: hard coded list of widgets according to the form name
    if (itemType != 'facility') {
      throw Exception('No form body registered for item type: $itemType');
    }

    return FacilityDetailsPageConsumer(itemType: itemType, id: id);
  }
}
