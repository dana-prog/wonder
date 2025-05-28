import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wonder/src/data/facility_item.dart';
import 'package:wonder/src/providers/lists_of_values_provider.dart';
import 'package:wonder/src/resources/labels.dart';

import '../../data/item.dart';
import '../../providers/items_provider.dart';
import '../async/async_value_widget.dart';
import '../fields/list_values_dropdown.dart';
import '../fields/users_dropdown.dart';
import 'room_count_dropdown.dart';

class ItemDetailsForm extends StatefulWidget {
  final FacilityItem? initialItem;
  final void Function(Item item) save;

  const ItemDetailsForm({
    this.initialItem,
    required this.save,
    super.key,
  });

  @override
  State<ItemDetailsForm> createState() => _FacilityDetailsFormState();
}

class _FacilityDetailsFormState extends State<ItemDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  final fields = ItemsLabels.getFieldLabels('facility');
  int? _number;
  String? _type;
  String? _subtype;
  String? _status;
  String? _owner;
  int? _roomCount;

  @override
  void initState() {
    super.initState();
    final item = widget.initialItem;
    if (item != null) {
      _number = item.number;
      _type = item.type;
      _subtype = item.subtype;
      _status = item.status;
      _owner = item.owner;
      _roomCount = item.roomCount;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(child: Column(children: spaceWidgets(fieldsLayout))),
    );
  }

  List<Widget> get fieldsLayout => spaceWidgets([
        Align(alignment: Alignment.centerLeft, child: _FacilityFormTitle(_number!, _type!)),
        _ownerFormField,
        _statusFormField,
        _subtypeFormField,
        _roomCountFormField,
      ]);

  // TODO: replace with padding instead of SizedBox
  List<Widget> spaceWidgets(List<Widget> widgets) => widgets.fold(<Widget>[], (previous, element) {
        return previous.isEmpty
            ? [element]
            : [
                ...previous,
                const SizedBox(height: 8, width: 10),
                element,
              ];
      });

  Widget get _subtypeFormField => ListValuesDropdownConsumer(
        label: fields['subtype'],
        listType: 'facilitySubtype',
        value: _subtype,
        onChanged: (value) => onChanged(context, () => _subtype = value),
        // validator: (value) => value == null ? 'Required' : null,
      );

  Widget get _statusFormField => ListValuesDropdownConsumer(
        label: fields['status'],
        listType: 'facilityStatus',
        value: _status,
        onChanged: (value) => onChanged(context, () => _status = value),
      );

  Widget get _ownerFormField => UsersDropdownConsumer(
        value: _owner,
        label: fields['owner'],
        onChanged: (value) => onChanged(context, () => _owner = value),
        validator: (value) => value == null ? 'Required' : null,
      );

  Widget get _roomCountFormField => RoomCountDropdown(
        value: _roomCount,
        onChanged: (value) => onChanged(context, () => _roomCount = value),
      );

  void onChanged(BuildContext context, VoidCallback fn) async {
    setState(fn);
    widget.save(FacilityItem.fromFields({
      // TODO: remove !
      ...widget.initialItem!.fields,
      'status': _status,
      'type': _type,
      'subtype': _subtype,
      'owner': _owner,
    }));
  }
}

const _itemType = 'facility';

class FacilityDetailsFormConsumer extends ConsumerWidget {
  final String id;

  const FacilityDetailsFormConsumer(this.id, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncFacility = ref.watch(itemProvider((_itemType, id)));

    return AsyncValueWidget<Item>(
      asyncValue: asyncFacility,
      dataBuilder: (item, _) {
        return ItemDetailsForm(
          initialItem: item as FacilityItem,
          save: (item) => save(item, ref),
        );
      },
    );
  }

  void save(Item item, WidgetRef ref) async {
    final notifier = ref.read(itemListProvider(item.itemType).notifier);
    await notifier.update(item);
  }
}

class _FacilityFormTitle extends ConsumerWidget {
  final int number;
  final String typeName;

  const _FacilityFormTitle(this.number, this.typeName);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final type = ref.watch(listValueProvider(typeName));
    return Text(
      textAlign: TextAlign.left,
      '${type.title} #$number',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
