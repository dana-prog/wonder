import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../data/item.dart';
import '../../logger.dart';
import '../../providers/items_provider.dart';
import '../../resources/labels.dart';
import '../../routes/locations.dart';
import '../platform/constants.dart';
import '../platform/error_view.dart';
import 'facility/facility_details_page.dart';

typedef SaveItemCallback = void Function(Item item);

class ItemForm extends StatelessWidget {
  final Item? item;
  final String? itemType;
  final SaveItemCallback save;

  ItemForm({
    required this.item,
    this.itemType,
    required this.save,
  }) : assert(item == null || itemType == null || item.itemType == itemType,
            'item.ItemType should be equal to itemType. item: $item, itemType: $itemType');

  String get resolvedItemType => item?.itemType ?? itemType!;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: kFormTitleBodySpacing,
        children: [
          _FormTitle(title: item?.title ?? Labels.newItem(resolvedItemType)),
          _FormBody(item: item, itemType: resolvedItemType, save: save),
        ],
      ),
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

    return asyncItem.when(
      data: (item) => ItemForm(
        item: item,
        itemType: itemType,
        save: (item) async =>
            id == null ? await addItem(context, ref, item) : await updateItem(context, ref, item),
      ),
      loading: LoadingItemForm.new,
      error: ErrorView.new,
    );
  }

  Future<void> updateItem(BuildContext _, WidgetRef ref, Item item) async {
    logger.d('[ItemCard.updateItem] add item: $item');
    final notifier = ref.watch(itemListProvider(itemType).notifier);

    await notifier.update(item);
  }

  Future<void> addItem(BuildContext context, WidgetRef ref, Item item) async {
    logger.d('[ItemCard.addItem] add item: $item');
    final router = GoRouter.of(context);
    final notifier = ref.watch(itemListProvider(itemType).notifier);

    final newItem = await notifier.add(item.fields);
    final route = getItemRoute(item: newItem);
    logger.d('[ItemCard.addItem] navigate to $route');
    router.replace(route);
  }
}

class _FormTitle extends StatelessWidget {
  final String title;

  const _FormTitle({required this.title});

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

class _FormBody extends StatelessWidget {
  final Item? item;
  final String? itemType;
  final SaveItemCallback save;

  const _FormBody({
    required this.item,
    required this.save,
    this.itemType,
  });

  @override
  Widget build(BuildContext context) {
// TODO: hard coded list of widgets according to the form name
    if (itemType != 'facility') {
      throw Exception('No form body registered for item type: $itemType');
    }

    return FacilityDetailsPage(
      initialItem: item,
      save: save,
    );
  }
}

class LoadingItemForm extends StatelessWidget {
  const LoadingItemForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Column(
        spacing: kFormTitleBodySpacing,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titlePlaceholderBuilder(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: kFieldSpacing,
            children: [
              fieldPlaceholderBuilder(),
              fieldPlaceholderBuilder(),
              fieldPlaceholderBuilder(),
              fieldPlaceholderBuilder(),
              picturesField(),
            ],
          ),
        ],
      ),
    );
  }

  Widget placeholderBuilder({double? width, double? height}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      height: height,
      width: width,
    );
  }

  Widget titlePlaceholderBuilder() => placeholderBuilder(width: 200, height: 36);

  Widget fieldPlaceholderBuilder() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: kFieldLabelSpacing,
        children: [
          fieldLabelPlaceholderBuilder(),
          fieldEditorPlaceholderBuilder(),
        ],
      );

  Widget fieldLabelPlaceholderBuilder() => placeholderBuilder(width: 50, height: 20);

  Widget fieldEditorPlaceholderBuilder() =>
      placeholderBuilder(width: double.infinity, height: kFieldEditorHeight);

  Widget picturesField() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: kFieldLabelSpacing,
        children: [
          fieldLabelPlaceholderBuilder(),
          placeholderBuilder(width: double.infinity, height: 216),
        ],
      );
}
