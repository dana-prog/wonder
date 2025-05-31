import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wonder/src/widgets/async/async_value_widget.dart';
import 'package:wonder/src/widgets/platform/field_label.dart';

import '../../data/facility_item.dart';
import '../../data/item.dart';
import '../../logger.dart';
import '../../providers/items_provider.dart';
import '../../resources/labels.dart';
import '../fields/list_values_dropdown.dart';
import '../fields/users_dropdown.dart';
import '../media/image_manager.dart';
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
  List<String>? _pictures;

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
      _pictures = item.pictures;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: spaceWidgets(
          widgets: [
            _ownerFormFieldBuilder(),
            _statusFormFieldBuilder(),
            _subtypeFormFieldBuilder(),
            _roomCountFormFieldBuilder(),
            _picturesBuilder(),
          ],
          verticalSpace: 16.0,
        ),
      ),
    );
  }

  // TODO: replace with padding instead of SizedBox
  List<Widget> spaceWidgets({
    required List<Widget> widgets,
    double? verticalSpace,
    double? horizontalSpace,
  }) =>
      widgets.fold(<Widget>[], (previous, element) {
        return previous.isEmpty
            ? [element]
            : [
                ...previous,
                SizedBox(height: verticalSpace, width: horizontalSpace),
                element,
              ];
      });

  Widget _subtypeFormFieldBuilder() => FieldLabel(
        label: fields['subtype']!,
        child: ListValuesDropdownConsumer(
          listType: 'facilitySubtype',
          value: _subtype,
          onChanged: (value) => onChanged(context, () => _subtype = value),
        ),
      );

  Widget _statusFormFieldBuilder() => FieldLabel(
        label: fields['status']!,
        child: ListValuesDropdownConsumer(
          listType: 'facilityStatus',
          value: _status,
          onChanged: (value) => onChanged(context, () => _status = value),
        ),
      );

  Widget _ownerFormFieldBuilder() => FieldLabel(
        label: fields['owner']!,
        child: UsersDropdownConsumer(
          value: _owner,
          onChanged: (value) => onChanged(context, () => _owner = value),
          validator: (value) => value == null ? 'Required' : null,
        ),
      );

  Widget _roomCountFormFieldBuilder() => RoomCountDropdown(
        value: _roomCount,
        onChanged: (value) => onChanged(context, () => _roomCount = value),
      );

  Widget _picturesBuilder() {
    return FieldLabel(
        label: fields['pictures']!,
        child: ImageManager(
      ids: _pictures ?? [],
      onAdd: (String id) async {
        onChanged(context, () {
          _pictures = _pictures ?? [];
          _pictures!.add(id);
        });
      },
      onRemove: (String id) async {
        logger.d('[FacilityDetailsPage.onRemove] Removing picture with id: $id from $_pictures');
        onChanged(context, () {
          final exists = _pictures?.contains(id) ?? false;
          assert(exists, 'Picture with id $id does not exist in the list');
          if (!exists) return;

          logger.d('[FacilityDetailsPage.onRemove] Removing picture with id: $id from $_pictures');
          _pictures!.removeWhere((pic) => pic == id);
          logger.d('[FacilityDetailsPage.onRemove] Removed picture with id: $id from $_pictures');
        });
      },
    ),);
  }

  void onChanged(BuildContext context, VoidCallback fn) {
    setState(fn);
    widget.save(FacilityItem.fromFields({
      // TODO: remove !
      ...widget.initialItem!.fields,
      'status': _status,
      'type': _type,
      'subtype': _subtype,
      'owner': _owner,
      'roomCount': _roomCount,
      'pictures': _pictures ?? [],
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
