import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wonder/src/data/facility_item.dart';
import 'package:wonder/src/data/list_value_item.dart';
import 'package:wonder/src/providers/lists_of_values_provider.dart';
import 'package:wonder/src/resources/labels.dart';
import 'package:wonder/src/widgets/fields/value_items_dropdown.dart';

import '../../logger.dart';
import '../../providers/facilities_provider.dart';
import '../async/async_value_widget.dart';
import '../fields/user_items_dropdown.dart';

class FacilityForm extends StatefulWidget {
  final FacilityItem? initialItem;

  const FacilityForm({
    this.initialItem,
    super.key,
  });

  @override
  State<FacilityForm> createState() => _FacilityFormState();
}

class _FacilityFormState extends State<FacilityForm> {
  final _formKey = GlobalKey<FormState>();
  final fields = ItemsLabels.facility.fields;
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
      child: Column(
        children: spaceWidgets(fieldsLayout),
      ),
    );
  }

  Future<void> save() async {
    logger.w(
        '[FacilityForm] NOT IMPLEMENTED save: $_number, $_type, $_subtype, $_status, $_owner, $_roomCount');
  }

  List<Widget> get fieldsLayout => spaceWidgets([
        _FormTitle(_number!, _type!),
        ownerFormField,
        statusFormField,
        Row(
          children: spaceWidgets([
            Expanded(child: subtypeFormField),
            Expanded(child: roomCountFormField),
          ]),
        ),
        saveButton,
      ], spaceTop: true);

  List<Widget> spaceWidgets(List<Widget> widgets, {bool spaceTop = false}) =>
      widgets.fold(<Widget>[], (previous, element) {
        return !spaceTop && previous.isEmpty
            ? [element]
            : [
                ...previous,
                const SizedBox(height: 10, width: 10),
                element,
              ];
      });

  Widget get numberFormField => TextFormField(
        initialValue: _number.toString(),
        decoration: InputDecoration(labelText: fields['number']),
        validator: (value) => int.tryParse(value ?? '') == null ? 'Enter a valid number' : null,
        // onChanged: saveForm,
        onSaved: (value) => _number = int.parse(value!),
      );

  Widget get typeFormField => ValueItemsDropdown(
        type: ValueItemType.facilityType,
        value: _type,
        decoration: InputDecoration(labelText: fields['type']),
        onChanged: (value) => setState(() => _type = value),
        // validator: (value) => value == null ? 'Required' : null,
      );

  Widget get subtypeFormField => ValueItemsDropdown(
        type: ValueItemType.facilitySubtype,
        value: _subtype,
        decoration: InputDecoration(labelText: fields['subtype']),
        onChanged: (value) => setState(() => _subtype = value),
        // validator: (value) => value == null ? 'Required' : null,
      );

  Widget get titleFormField => ValueItemsDropdown(
        type: ValueItemType.facilitySubtype,
        value: _subtype,
        decoration: InputDecoration(labelText: fields['subtype']),
        onChanged: (value) => setState(() => _subtype = value),
        // validator: (value) => value == null ? 'Required' : null,
      );

  Widget get statusFormField => ValueItemsDropdown(
        type: ValueItemType.facilityStatus,
        value: _status,
        decoration: InputDecoration(labelText: 'Status'),
        onChanged: (value) => setState(() => _status = value),
        // validator: (value) => value == null ? 'Required' : null,
      );

  Widget get ownerFormField => UserItemsDropdown(
        value: _owner,
        decoration: InputDecoration(labelText: fields['owner']),
        onChanged: (value) => setState(() => _owner = value),
        validator: (value) => value == null ? 'Required' : null,
      );

  Widget get roomCountFormField => TextFormField(
        decoration: InputDecoration(labelText: 'Room Count'),
        initialValue: _roomCount.toString(),
        keyboardType: TextInputType.number,
        validator: (value) => int.tryParse(value ?? '') == null ? 'Enter a valid number' : null,
        onSaved: (value) => _roomCount = int.parse(value!),
      );

  Widget get saveButton => ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            logger.w(
                '[FacilityForm] NOT IMPLEMENTED onSubmit: $_number, $_type, $_subtype, $_status, $_owner, $_roomCount');
            // widget.onSubmit(FacilityItem(
            //   number: _number!,
            //   type: _type!,
            //   subtype: _subtype!,
            //   status: _status!,
            //   owner: _owner!,
            //   roomCount: _roomCount,
            // ));
          }
        },
        child: const Text(Labels.save),
      );
}

class FacilityFormConsumer extends ConsumerWidget {
  final String id;

  const FacilityFormConsumer(this.id, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncFacility = ref.watch(facilityProvider(id));

    return AsyncValueWidget<FacilityItem>(
      asyncValue: asyncFacility,
      dataBuilder: (item, _) {
        return FacilityForm(initialItem: item);
      },
    );
  }
}

class _FormTitle extends StatelessWidget {
  final int number;
  final String typeName;

  const _FormTitle(this.number, this.typeName);

  @override
  Widget build(BuildContext context) {
    return AsyncValueProviderWidget<ListValueItem>(
        provider: listValueProvider(typeName),
        dataBuilder: (
          ListValueItem type,
          _,
          __,
        ) =>
            Text(
              '${type.title} #$number',
              style: Theme.of(context).textTheme.headlineSmall,
            ));
  }
}
