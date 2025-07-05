import 'package:flutter/material.dart';
import 'package:wonder/src/widgets/items/facility/fields/facility_dropdowns.dart';

import '../../../data/facility_item.dart';
import '../../../data/item.dart';
import '../../../logger.dart';
import '../../../resources/labels.dart';
import '../../../storage/file_storage_plugin.dart';
import '../../media/image_manager.dart';
import '../../platform/constants.dart';
import '../../platform/field_label.dart';
import '../user/users_dropdown.dart';
import 'fields/facility_number_text_box.dart';

enum SaveMode {
  onChange,
  onExplicitSave,
}

typedef SaveCallback<T> = void Function(T item);

class FacilityDetailsPage extends StatefulWidget {
  final Item? initialItem;
  final SaveCallback<FacilityItem> save;

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
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    assert(widget.initialItem is FacilityItem?, 'Initial item must be of type FacilityItem');
    logger.t(
        '[FacilityDetailsPage.initState] Initial item: ${widget.initialItem?.toString() ?? 'null'}');
    final item = widget.initialItem as FacilityItem?;
    if (item != null) {
      _number = item.number;
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
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          spacing: kFieldSpacing,
          children: [
            widget.initialItem == null ? _numberFormFieldBuilder() : null,
            _ownerFormFieldBuilder(),
            _statusFormFieldBuilder(),
            _subtypeFormFieldBuilder(),
            _roomCountFormFieldBuilder(),
            _picturesBuilder(),
            saveMode == SaveMode.onExplicitSave ? _saveButton() : null,
          ].whereType<Widget>().toList(),
        ),
      ),
    );
  }

  Widget _numberFormFieldBuilder() => FieldLabel(
        label: fields['number']!,
        child: FacilityNumberTextBox(
          initialValue: _number,
          onChanged: (value) => onChanged(context, () => _number = value),
        ),
      );

  Widget _subtypeFormFieldBuilder() => FieldLabel(
        label: fields['subtype']!,
        child: FacilitySubtypeDropdown(
          selectedId: _subtype,
          onChanged: (value) => onChanged(context, () => _subtype = value?.id),
        ),
      );

  Widget _statusFormFieldBuilder() => FieldLabel(
        label: fields['status']!,
        child: FacilityStatusDropdown(
          selectedId: _status,
          // style: TextStyle(fontWeight: FontWeight.bold),
          // itemHeight: kFieldEditorHeight,
          onChanged: (value) => onChanged(context, () {
            logger.d(
                '[FacilityDetailsPage._statusFormFieldBuilder.onChanged] Selected status: $value');
            _status = value?.id;
          }),
        ),
      );

  Widget _ownerFormFieldBuilder() => FieldLabel(
        label: fields['owner']!,
        child: UsersDropdownConsumer(
          selectedId: _owner,
          onChanged: (value) => onChanged(
            context,
            () {
              logger.d(
                  '[FacilityDetailsPage._ownerFormFieldBuilder.onChanged] Selected owner: $value');
              _owner = value?.id;
            },
          ),
        ),
      );

  Widget _roomCountFormFieldBuilder() => FieldLabel(
        label: ItemsLabels.getFieldLabels('facility')['roomCount']!,
        child: FacilityRoomCountDropdown(
          value: _roomCount,
          onChanged: (value) => onChanged(context, () => _roomCount = value),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );

  Widget _picturesBuilder() {
    return FieldLabel(
      label: ItemsLabels.getFieldLabels('facility')['pictures']!,
      child: widget.initialItem?.id != null
          ? ImageManager(
              fileUrls: _pictures ?? [],
              fileContext: FileContext(
                itemType: 'facility',
                itemId: widget.initialItem!.id,
                fieldName: 'pictures',
              ),
              onAdd: (String id) async {
                onChanged(context, () {
                  _pictures = _pictures ?? [];
                  _pictures!.add(id);
                });
              },
              onRemove: (String id) async {
                logger.d(
                    '[FacilityDetailsPage.onRemove] Removing picture with id: $id from $_pictures');
                onChanged(context, () {
                  final exists = _pictures?.contains(id) ?? false;
                  assert(exists, 'Picture with id $id does not exist in the list');
                  if (!exists) return;

                  logger.d(
                      '[FacilityDetailsPage.onRemove] Removing picture with id: $id from $_pictures');
                  _pictures!.removeWhere((pic) => pic == id);
                  logger.d(
                      '[FacilityDetailsPage.onRemove] Removed picture with id: $id from $_pictures');
                });
              },
            )
          : ImageManagerBorder(
              child: Text(Labels.saveItemToAddPictures),
            ),
    );
  }

  // TODO: move save to item_form?
  Widget _saveButton() => ElevatedButton(
        onPressed: onSave,
        child: Text(Labels.save),
      );

  SaveMode get saveMode => widget.initialItem == null ? SaveMode.onExplicitSave : SaveMode.onChange;

  void onChanged(BuildContext context, VoidCallback fn) {
    setState(fn);
    if (saveMode == SaveMode.onChange) {
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

  void onSave() {
    logger.d('[FacilityDetailsPage.onSave]');

    if (!(_formKey.currentState?.validate() ?? true)) {
      logger.d('[FacilityDetailsPage.onSave] Form validation failed');
      return;
    }

    widget.save(FacilityItem.fromFields({
      ...(widget.initialItem?.fields ?? {}),
      'number': _number,
      'status': _status,
      'subtype': _subtype,
      'owner': _owner,
      'roomCount': _roomCount,
      'pictures': _pictures ?? [],
    }));
  }
}

class LoadingFacilityDetailsPage extends StatelessWidget {
  const LoadingFacilityDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    logger.d('[LoadingFacilityDetailsPage] build');
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
