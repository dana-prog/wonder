import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/facility_item.dart';
import '../../../data/item.dart';
import '../../../logger.dart';
import '../../../providers/items_provider.dart';
import '../../../resources/labels.dart';
import '../../async/async_value_widget.dart';
import '../../media/image_manager.dart';
import '../../platform/field_label.dart';
import '../list_value/list_values_dropdown.dart';
import '../user/users_dropdown.dart';
import 'room_count_dropdown.dart';

const _numberFieldWidth = 100.0;
const _fieldHeight = 36.0;

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
  int? _number;
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
      _number = item.number;
      _type = item.type;
      _subtype = item.subtype;
      _status = item.status;
      _owner = item.owner;
      _roomCount = item.roomCount;
      _pictures = item.pictures;
    } else {
      logger.d('[FacilityDetailsPage.initState] Initial item is null, setting default values');
      _number = 2;
      // TODO: remove hard coded value for villa
      _type = 'd9c1d2a1-17fe-4f3f-b035-dcbe4905e444';
      _subtype = '41af2d26-7a9d-49f4-91f7-34f7965410e4';
      _status = '126cd917-9ee1-45a7-8bdf-190ed1f67e3c';
      _owner = 'c8cbd709-bdb7-4fb7-8b83-49fa90d2ecfc';
      _roomCount = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: spaceWidgets(
          verticalSpace: 16.0,
          widgets: [
            Row(
              children: spaceWidgets(
                horizontalSpace: 16.0,
                widgets: [
                  SizedBox(
                    width: _numberFieldWidth,
                    child: _numberFormFieldBuilder(),
                  ),
                  Expanded(
                    child: _ownerFormFieldBuilder(),
                  ),
                ],
              ),
            ),
            _statusFormFieldBuilder(),
            _subtypeFormFieldBuilder(),
            _roomCountFormFieldBuilder(),
            _picturesBuilder(),
            _saveButton(),
          ],
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

  Widget _numberFormFieldBuilder() => FieldLabel(
        label: fields['number']!,
        child: SizedBox(
          height: _fieldHeight,
          child: TextFormField(
            initialValue: _number?.toString(),
            decoration: InputDecoration(
              // set isDense to true to avoid extra top padding
              isDense: true,
              // set filled to true to add background color
              filled: true,
            ),
            keyboardType: TextInputType.number,
            // textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.center,
            onChanged: (value) => onChanged(context, () => _number = int.tryParse(value)),
            validator: (value) => value == null || value.isEmpty ? 'Required' : null,
          ),
        ),
      );

  Widget _subtypeFormFieldBuilder() => FieldLabel(
        label: fields['subtype']!,
        child: ListValuesDropdownConsumer(
          listType: 'facilitySubtype',
          style: TextStyle(fontWeight: FontWeight.bold),
          itemHeight: _fieldHeight,
          value: _subtype,
          onChanged: (value) => onChanged(context, () => _subtype = value),
        ),
      );

  Widget _statusFormFieldBuilder() => FieldLabel(
        label: fields['status']!,
        child: ListValuesDropdownConsumer(
          listType: 'facilityStatus',
          value: _status,
          style: TextStyle(fontWeight: FontWeight.bold),
          itemHeight: _fieldHeight,
          onChanged: (value) => onChanged(context, () => _status = value),
        ),
      );

  Widget _ownerFormFieldBuilder() => FieldLabel(
        label: fields['owner']!,
        child: UsersDropdownConsumer(
          value: _owner,
          // style: TextStyle(fontWeight: FontWeight.bold),
          itemHeight: _fieldHeight,
          onChanged: (value) => onChanged(context, () => _owner = value),
          validator: (value) => value == null ? 'Required' : null,
        ),
      );

  Widget _roomCountFormFieldBuilder() => RoomCountDropdown(
        value: _roomCount,
        onChanged: (value) => onChanged(context, () => _roomCount = value),
        style: TextStyle(fontWeight: FontWeight.bold),
        itemHeight: _fieldHeight,
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

            logger
                .d('[FacilityDetailsPage.onRemove] Removing picture with id: $id from $_pictures');
            _pictures!.removeWhere((pic) => pic == id);
            logger.d('[FacilityDetailsPage.onRemove] Removed picture with id: $id from $_pictures');
          });
        },
      ),
    );
  }

  Widget _saveButton() => ElevatedButton(
        onPressed: () {
          logger.d('[FacilityDetailsPage._saveButton.onPressed]');
          widget.save(FacilityItem.fromFields({
            ...(widget.initialItem?.fields ?? {}),
            'number': _number,
            'status': _status,
            'type': _type,
            'subtype': _subtype,
            'owner': _owner,
            'roomCount': _roomCount,
            'pictures': _pictures ?? [],
          }));
        },
        child: Text('Save'),
      );

  void onChanged(BuildContext context, VoidCallback fn) {
    setState(fn);
    if (widget.initialItem != null) {
      widget.save(FacilityItem.fromFields({
        ...(widget.initialItem?.fields ?? {}),
        'status': _status,
        'type': _type,
        'subtype': _subtype,
        'owner': _owner,
        'roomCount': _roomCount,
        'pictures': _pictures ?? [],
      }));
    }
  }
}

class FacilityDetailsPageConsumer extends ConsumerWidget {
  final String itemType;
  final String? id;

  const FacilityDetailsPageConsumer({
    required this.itemType,
    this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncItem = id != null ? ref.watch(itemProvider((itemType, id!))) : AsyncValue.data(null);
    final notifier = ref.watch(itemListProvider(itemType).notifier);

    return AsyncValueWidget(
      asyncValue: asyncItem,
      dataBuilder: (initialItem, _) => FacilityDetailsPage(
        initialItem: initialItem,
        save: (item) => initialItem == null ? notifier.create(item) : notifier.update(item),
      ),
    );
  }
}
