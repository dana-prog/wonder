import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wonder/src/widgets/async/async_value_widget.dart';

import '../../data/facility_item.dart';
import '../../data/item.dart';
import '../../providers/items_provider.dart';
import '../../resources/labels.dart';
import '../fields/list_values_dropdown.dart';
import '../fields/users_dropdown.dart';
import 'room_count_dropdown.dart';

class FacilityDetailsPage extends StatefulWidget {
  final Item? initialItem;
  final void Function(Item item) save;

  const FacilityDetailsPage({
    this.initialItem,
    required this.save,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _FacilityDetailsPageState();
}

class _FacilityDetailsPageState extends State<FacilityDetailsPage> {
  final fields = ItemsLabels.getFieldLabels('facility');
  // int? _number;
  String? _type;
  String? _subtype;
  String? _status;
  String? _owner;
  int? _roomCount;

  @override
  void initState() {
    super.initState();
    assert(widget.initialItem is FacilityItem?, 'Initial item must be of type FacilityItem');
    final item = widget.initialItem as FacilityItem?;
    if (item != null) {
      // _number = item.number;
      _type = item.type;
      _subtype = item.subtype;
      _status = item.status;
      _owner = item.owner;
      _roomCount = item.roomCount;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: spaceWidgets(
          [
            _ownerFormField,
            _statusFormField,
            _subtypeFormField,
            _roomCountFormField,
          ],
        ),
      ),
    );
  }

  List<Widget> buildFieldsLayout() => spaceWidgets([
        // Align(alignment: Alignment.centerLeft, child: _FacilityFormTitle(_number!, _type!)),
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

class FacilityDetailsPageConsumer extends ConsumerWidget {
  final dynamic itemType;
  final dynamic id;

  const FacilityDetailsPageConsumer(this.itemType, this.id);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncItem = ref.watch(itemProvider((itemType, id)));
    final notifier = ref.watch(itemListProvider(itemType).notifier);

    return AsyncValueWidget(
      asyncValue: asyncItem,
      dataBuilder: (item, _) => FacilityDetailsPage(
        initialItem: item,
        save: (item) => notifier.update(item),
      ),
    );
  }
}
