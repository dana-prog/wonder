import 'dart:typed_data';

import 'package:flutter/material.dart' hide Chip;
import 'package:mime/mime.dart';
import 'package:wonder/src/client/items_client.dart';
import 'package:wonder/src/client/wix/wix_items_client.dart';
import 'package:wonder/src/data/facility_item.dart';
import 'package:wonder/src/storage/file_storage.dart';
import 'package:wonder/src/storage/file_storage_plugin.dart';
import 'package:wonder/src/widgets/platform/dropdown.dart';
import 'package:wonder_api/src/utils/image_selector.dart';

import '../logger.dart';
import 'platform/data_viewer.dart';

enum CallType { items, staticLists, files }

enum ItemType { facility, ticket, user, listValue }

enum ItemsOperation { fetchAll, fetchSingle, create, update, delete }

enum ListsOperation { users, listsValues, usersAndListsValues }

enum FilesOperation { save, get }

var _newItemFields = {
  'itemType': 'facility',
  'number': 42,
  'type': 'd9c1d2a1-17fe-4f3f-b035-dcbe4905e444',
  'subtype': '41af2d26-7a9d-49f4-91f7-34f7965410e4',
  'status': '126cd917-9ee1-45a7-8bdf-190ed1f67e3c',
  'owner': '1246fe4d-c2e4-406b-9cb9-b2fedbf52c3d',
  'roomCount': 1,
};
var _updatedItem = FacilityItem(
  id: 'beba71a9-1af7-484e-b2f9-27080cf84047',
  number: 42,
  status: '126cd917-9ee1-45a7-8bdf-190ed1f67e3c',
  type: 'd9c1d2a1-17fe-4f3f-b035-dcbe4905e444',
  subtype: '41af2d26-7a9d-49f4-91f7-34f7965410e4',
  owner: '1246fe4d-c2e4-406b-9cb9-b2fedbf52c3d',
  roomCount: 1,
);

class ApiCalls extends StatefulWidget {
  final ItemsClient itemsClient;
  final FileStorage fileService;

  const ApiCalls({required this.itemsClient, required this.fileService});

  @override
  State<ApiCalls> createState() => _ApiCallsState();
}

class _ApiCallsState extends State<ApiCalls> {
  List<_ApiCall> calls = [];
  CallType _selectedCallType = CallType.files; //CallTypes.values.first.name;
  ItemType _selectedItemType = ItemType.values.first;
  ItemsOperation _selectedItemOperation = ItemsOperation.values.first;
  ListsOperation _selectedListsOperation = ListsOperation.values.first;
  FilesOperation _selectedFileOperation = FilesOperation.get; //FilesOperation.values.first.name;

  // TODO: move to separate params objects
  final String _fetchItemId = '';
  String? _fetchListName = _listNames.first;
  Uint8List? _fileBytes;
  String? _fileName;
  String? _mimeType;
  FileContext _fileContext = FileContext(
    itemType: 'facility',
    itemId: 'beba71a9-1af7-484e-b2f9-27080cf84047',
    fieldName: 'pictures',
  );
  String _fileId =
      'wix:image://v1/1246fe_7e77b42d3ff44f24b445d4b81ad21b0d~mv2.png/igal_villa.jpg#originWidth=600&originHeight=450';

  @override
  Widget build(BuildContext context) {
    final result = calls.isNotEmpty ? calls.last.result : null;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 24,
      children: [
        ...buildDropdowns(),
        buildParamsSection(),
        buildCallApiButton(),
        result != null
            ? Expanded(
                child: Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                  child: SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: result is Uint8List
                          ? Image.memory(result)
                          : DataViewer(data: result, viewType: 'text'),
                    ),
                  ),
                  // child: SingleChildScrollView(
                  //   child: JsonView.string(jsonEncode(calls.last.result)),
                  // ),
                ),
              )
            : SizedBox.shrink(),
      ],
    );
  }

  Widget buildCallTypesDropdown() => Dropdown<String>(
    items: CallType.values.map((e) => e.name).toList(),
    selectedItem: _selectedCallType.name,
    onChanged: (value) => setState(() {
      _selectedCallType = CallType.values.byName(value!);
    }),
  );

  Widget buildItemTypesDropdown() => Dropdown<String>(
    items: ItemType.values.map((e) => e.name).toList(),
    selectedItem: _selectedItemType.name,
    onChanged: (value) => setState(() {
      _selectedItemType = ItemType.values.byName(value!);
    }),
  );

  Widget buildItemOperationsDropdown() => Dropdown<String>(
    items: ItemsOperation.values.map((e) => e.name).toList(),
    selectedItem: _selectedItemOperation.name,
    onChanged: (value) => setState(() {
      _selectedItemOperation = ItemsOperation.values.byName(value!);
    }),
  );

  Widget buildListOperationsDropdown() => Dropdown<String>(
    items: ListsOperation.values.map((e) => e.name).toList(),
    selectedItem: _selectedListsOperation.name,
    onChanged: (value) => setState(() {
      _selectedListsOperation = ListsOperation.values.byName(value!);
    }),
  );

  Widget buildFileOperationsDropdown() => Dropdown<String>(
    items: FilesOperation.values.map((e) => e.name).toList(),
    selectedItem: _selectedFileOperation.name,
    onChanged: (value) => setState(() {
      _selectedFileOperation = FilesOperation.values.byName(value!);
    }),
  );

  Widget buildDropdown({
    required List<Enum> values,
    required Enum selectedValue,
    required void Function(Enum?) onChanged,
  }) => Dropdown<String>(
    items: values.map((e) => e.name).toList(),
    selectedItem: selectedValue.name,
    onChanged: (value) => setState(() {
      onChanged(values.byName(value!));
    }),
  );

  List<Widget> buildDropdowns() {
    final rows = <Widget>[];
    rows.add(buildCallTypesDropdown());
    switch (_selectedCallType) {
      case CallType.items:
        rows.add(buildItemTypesDropdown());
        rows.add(buildItemOperationsDropdown());
        break;
      case CallType.staticLists:
        rows.add(buildListOperationsDropdown());
        break;
      case CallType.files:
        rows.add(buildFileOperationsDropdown());
        break;
    }

    return rows;
  }

  // List<Widget> buildChipRows() {
  //   final chipRows = <Widget>[];
  //   chipRows.add(buildCallTypesChips());
  //   switch (_selectedCallType) {
  //     case CallType.items:
  //       chipRows.add(buildItemTypesChips());
  //       chipRows.add(buildItemOperationsChips());
  //       break;
  //     case CallType.staticLists:
  //       chipRows.add(buildListOperationsChips());
  //       break;
  //     case CallType.files:
  //       chipRows.add(buildFileOperationsChips());
  //       break;
  //   }
  //
  //   return chipRows;
  // }

  // Widget buildCallTypesChips() => buildChipsRow(
  //   options: CallType.values.map((e) => e.name).toList(),
  //   selectedValue: _selectedCallType.name,
  //   onSelected: (value) => _selectedCallType = CallType.values.byName(value),
  // );

  // Widget buildItemTypesChips() => buildChipsRow(
  //   options: ItemType.values.map((e) => e.name).toList(),
  //   selectedValue: _selectedItemType.name,
  //   onSelected: (value) => _selectedItemType = ItemType.values.byName(value),
  // );

  // Widget buildItemOperationsChips() => buildChipsRow(
  //   options: ItemsOperation.values.map((e) => e.name).toList(),
  //   selectedValue: _selectedItemOperation.name,
  //   onSelected: (value) => _selectedItemOperation = ItemsOperation.values.byName(value),
  // );

  // Widget buildListOperationsChips() => buildChipsRow(
  //   options: ListsOperation.values.map((e) => e.name).toList(),
  //   selectedValue: _selectedListsOperation.name,
  //   onSelected: (value) => _selectedListsOperation = ListsOperation.values.byName(value),
  // );

  // Widget buildFileOperationsChips() => buildChipsRow(
  //   options: FilesOperation.values.map((e) => e.name).toList(),
  //   selectedValue: _selectedFileOperation.name,
  //   onSelected: (value) => _selectedFileOperation = FilesOperation.values.byName(value),
  // );

  // Widget buildChipsRow({
  //   required List<String> options,
  //   required String selectedValue,
  //   required void Function(String) onSelected,
  // }) {
  //   return Row(
  //     spacing: 8,
  //     children: options
  //         .map(
  //           (option) => ChoiceChip(
  //             label: Text(option.titleCase),
  //             selected: selectedValue == option,
  //             onSelected: (_) => setState(() => onSelected(option)),
  //           ),
  //         )
  //         .toList(),
  //   );
  // }

  Widget buildCallApiButton() {
    return ElevatedButton(onPressed: callApi, child: const Text('Call API'));
  }

  Widget buildParamsSection() {
    if (_selectedCallType == CallType.staticLists &&
        _selectedListsOperation == ListsOperation.listsValues) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return _ListsValuesParams(
            listName: _fetchListName,
            onChanged: (value) {
              setState(() {
                _fetchListName = value;
              });
            },
          );
        },
      );
    }

    if (_selectedCallType == CallType.files && _selectedFileOperation == FilesOperation.save) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return _SaveFileParams(
            fileName: _fileName,
            fileContext: _fileContext,
            onPicked:
                ({required Uint8List fileBytes, required String name, required String mimeType}) {
                  setState(() {
                    _fileBytes = fileBytes;
                    _fileName = name;
                    _mimeType = mimeType;
                  });
                },
            onItemIdChanged: (String id) {
              setState(() {
                _fileContext = FileContext(
                  itemType: _fileContext.itemType,
                  itemId: id,
                  fieldName: _fileContext.fieldName,
                );
              });
            },
          );
        },
      );
    }

    if (_selectedCallType == CallType.files && _selectedFileOperation == FilesOperation.get) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return _GetFileParams(
            fileId: _fileId,
            onChanged: (id) {
              setState(() {
                _fileId = id;
              });
            },
          );
        },
      );
    }

    return SizedBox.shrink();
  }

  void callApi() async {
    dynamic result;
    switch (_selectedCallType) {
      case CallType.items:
        result = await callItemsApi();
        break;
      case CallType.staticLists:
        result = await callListsApi();
        break;
      case CallType.files:
        result = await callFileStorageApi();
        break;
    }

    setState(() {
      logger.d('[ApiCalls.setState]');
      calls.add(
        _ApiCall(
          itemType: _selectedItemType.name,
          operation: _selectedItemOperation.name,
          result: result,
        ),
      );
    });
  }

  Future<dynamic> callItemsApi() async {
    switch (_selectedItemOperation) {
      case ItemsOperation.fetchAll:
        return await widget.itemsClient.fetchItems<FacilityItem>(itemType: _selectedItemType.name);
      case ItemsOperation.fetchSingle:
        return await widget.itemsClient.fetchItem<FacilityItem>(
          itemType: _selectedItemType.name,
          id: _fetchItemId,
        );
      case ItemsOperation.create:
        return await widget.itemsClient.createItem<FacilityItem>(_newItemFields);
      case ItemsOperation.update:
        return await widget.itemsClient.updateItem<FacilityItem>(_updatedItem);
      case ItemsOperation.delete:
        return await widget.itemsClient.deleteItem(_updatedItem);
    }
  }

  Future<dynamic> callListsApi() async {
    final res = await (widget.itemsClient as WixItemsClient).fetchStaticLists();
    logger.d('[ApiCalls.callListsApi] _selectedListsOperation: $_selectedListsOperation');
    switch (_selectedListsOperation) {
      case ListsOperation.users:
        return res['user'];
      case ListsOperation.listsValues:
        final listName = _fetchListName;
        return listName != null
            ? res['listValue']!.where((value) => value['type'] == listName).toList()
            : res['listValue'];
      case ListsOperation.usersAndListsValues:
        return res;
    }
  }

  Future<dynamic> callFileStorageApi() async {
    switch (_selectedFileOperation) {
      case FilesOperation.save:
        if (_fileBytes == null || _fileName == null || _mimeType == null) {
          throw Exception('Stream, name, and mimeType must be provided for file upload');
        }
        return await widget.fileService.add(
          fileBytes: _fileBytes!,
          name: _fileName!,
          mimeType: _mimeType!,
          fileContext: _fileContext,
        );
      case FilesOperation.get:
        if (_fileId.isEmpty) {
          throw Exception('File ID must be provided for file retrieval');
        }
        return await widget.fileService.get(_fileId);
    }
  }
}

class _ApiCall {
  final String itemType;
  final String operation;
  final dynamic result;

  _ApiCall({required this.itemType, required this.operation, required this.result});

  String get resultType => result is Uint8List ? 'bytes' : 'json';

  dynamic get jsonResult {
    if (result is List) {
      return result.map((item) {
        return item.toJson();
      }).toList();
    }

    return result.toJson();
  }
}

const _listNames = [
  'domain',
  'ticketSeverity',
  'ticketStatus',
  'facilityType',
  'facilitySubtype',
  'facilityStatus',
];

class _ListsValuesParams extends StatelessWidget {
  final String? listName;
  final ValueChanged<String?> onChanged;

  const _ListsValuesParams({this.listName, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('List Name: $listName'),
        Dropdown(items: _listNames, selectedItem: listName, onChanged: onChanged),
      ],
    );
  }
}

const _fileNameHintText = 'Click to select a file to upload';
const _facilityIdHintText = 'Fill facility ID for the picture';

class _SaveFileParams extends StatelessWidget {
  final String? fileName;
  final FileContext fileContext;
  final void Function({
    required Uint8List fileBytes,
    required String name,
    required String mimeType,
  })
  onPicked;
  final void Function(String id)? onItemIdChanged;

  const _SaveFileParams({
    required this.onPicked,
    required this.onItemIdChanged,
    required this.fileContext,
    this.fileName,
  });

  @override
  Widget build(BuildContext context) {
    final fileNameController = TextEditingController(text: fileName ?? _fileNameHintText);
    final itemIdController = TextEditingController(
      text: fileContext.itemId.isNotEmpty ? fileContext.itemId : _facilityIdHintText,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        ImageSelector(
          onPicked: (picked) async {
            logger.d('onPicked in _SaveFileParams: ${picked.name}, ${picked.mimeType}');
            final extension = extensionFromMime(picked.mimeType ?? '') ?? '';
            final fileName = picked.name + (extension.isNotEmpty ? '.$extension' : '');
            fileNameController.text = fileName;
            final fileBytes = await picked.readAsBytes();

            onPicked(
              fileBytes: fileBytes,
              name: fileName,
              mimeType: picked.mimeType ?? 'application/octet-stream',
            );
          },
          child: TextField(
            controller: fileNameController,
            decoration: const InputDecoration(labelText: 'File Name'),
            readOnly: true,
            enabled: false,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: itemIdController,
                decoration: const InputDecoration(labelText: 'Facility ID'),
                enabled: false,
                onChanged: (facilityId) {
                  itemIdController.text = facilityId.isNotEmpty ? facilityId : _facilityIdHintText;
                  onItemIdChanged?.call(facilityId);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _GetFileParams extends StatelessWidget {
  final String fileId;
  final void Function(String id) onChanged;

  const _GetFileParams({required this.fileId, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final fileIdController = TextEditingController(text: fileId);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: fileIdController,
          decoration: const InputDecoration(labelText: 'File ID'),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
