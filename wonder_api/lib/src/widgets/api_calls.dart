import 'package:flutter/material.dart' hide Chip;
import 'package:recase/recase.dart';
import 'package:wonder/src/client/client.dart';
import 'package:wonder/src/client/wix/wix_client.dart';
import 'package:wonder/src/data/facility_item.dart';
import 'package:wonder/src/widgets/platform/dropdown.dart';

import '../logger.dart';
import 'platform/data_viewer.dart';

const _callTypes = ['items', 'staticLists', 'images'];
const _itemTypes = ['facility', 'ticket', 'user'];
const _itemsOperations = ['fetchAll', 'fetchSingle', 'create', 'update', 'delete'];
const _listsOperations = ['users', 'listsValues', 'users&ListsValues'];
const _imageOperations = ['generateUploadUrl', 'upload'];

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
var _fetchItemId = 'beba71a9-1af7-484e-b2f9-27080cf84047';

class ApiCalls extends StatefulWidget {
  final Client client;

  const ApiCalls(this.client);

  @override
  State<ApiCalls> createState() => _ApiCallsState();
}

class _ApiCallsState extends State<ApiCalls> {
  List<_ApiCall> calls = [];
  String _selectedCallType = _callTypes.first;
  String _selectedItemType = _itemTypes.first;
  String _selectedItemOperation = _itemsOperations.first;
  String _selectedListsOperation = _listsOperations.first;
  String _selectedImageOperation = _imageOperations.first;
  Map<String, Map<String, dynamic>> params = {
    'staticLists_listsValues': {'listName': _listNames.first},
  };

  @override
  Widget build(BuildContext context) {
    logger.t('[ApiCalls] build, calls.length: ${calls.length}');
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        ...buildChipRows(),
        buildParamsSection(),
        buildCallApiButton(),
        calls.isNotEmpty
            ? Expanded(
                child: Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                  child: SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: DataViewer(data: calls.last.result, viewType: 'json'),
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

  List<Widget> buildChipRows() {
    final chipRows = <Widget>[];
    chipRows.add(buildCallTypesChips());
    switch (_selectedCallType) {
      case 'items':
        chipRows.add(buildItemTypesChips());
        chipRows.add(buildItemOperationsChips());
        break;
      case 'staticLists':
        chipRows.add(buildListOperationsChips());
        break;
      case 'images':
        chipRows.add(buildImageOperationsChips());
        break;
    }

    return chipRows;
  }

  Widget buildCallTypesChips() => buildChipsRow(
    options: _callTypes,
    selectedValue: _selectedCallType,
    onSelected: (value) => _selectedCallType = value,
  );

  Widget buildItemTypesChips() => buildChipsRow(
    options: _itemTypes,
    selectedValue: _selectedItemType,
    onSelected: (value) => _selectedItemType = value,
  );

  Widget buildItemOperationsChips() => buildChipsRow(
    options: _itemsOperations,
    selectedValue: _selectedItemOperation,
    onSelected: (value) => _selectedItemOperation = value,
  );

  Widget buildListOperationsChips() => buildChipsRow(
    options: _listsOperations,
    selectedValue: _selectedListsOperation,
    onSelected: (value) => _selectedListsOperation = value,
  );

  Widget buildImageOperationsChips() => buildChipsRow(
    options: _imageOperations,
    selectedValue: _selectedImageOperation,
    onSelected: (value) => _selectedImageOperation = value,
  );

  Widget buildChipsRow({
    required List<String> options,
    required String selectedValue,
    required void Function(String) onSelected,
  }) {
    return Row(
      spacing: 8,
      children: options
          .map(
            (option) => ChoiceChip(
              label: Text(option.titleCase),
              selected: selectedValue == option,
              onSelected: (_) => setState(() => onSelected(option)),
            ),
          )
          .toList(),
    );
  }

  Widget buildCallApiButton() {
    return ElevatedButton(onPressed: callApi, child: const Text('Call API'));
  }

  Widget buildParamsSection() {
    if (_selectedCallType == 'staticLists' && _selectedListsOperation == 'listsValues') {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return _ListsValuesParams(
            listName: params['staticLists_listsValues']!['listName'],
            onChanged: (value) {
              setState(() {
                params['staticLists_listsValues']!['listName'] = value;
                logger.d('[ApiCalls.setState] params: ${params['staticLists_listsValues']}');
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
      case 'items':
        result = await callItemsApi();
        break;
      case 'staticLists':
        result = await callListsApi();
        break;
      // case 'images':
      //   result = await callImagesApi();
      //   break;
      default:
        throw Exception('Unknown call type: $_selectedCallType');
    }

    setState(() {
      logger.d('[ApiCalls.setState]');
      calls.add(
        _ApiCall(itemType: _selectedItemType, operation: _selectedItemOperation, result: result),
      );
    });
  }

  Future<dynamic> callItemsApi() async {
    switch (_selectedItemOperation) {
      case 'fetchAll':
        return await widget.client.fetchItems<FacilityItem>(itemType: _selectedItemType);
      case 'fetchSingle':
        return await widget.client.fetchItem<FacilityItem>(
          itemType: _selectedItemType,
          id: _fetchItemId,
        );
      case 'create':
        return await widget.client.createItem<FacilityItem>(_newItemFields);
      case 'update':
        return await widget.client.updateItem<FacilityItem>(_updatedItem);
      case 'delete':
        return await widget.client.deleteItem(_updatedItem);
      default:
        throw Exception('Unknown operation: $_selectedItemOperation');
    }
  }

  Future<dynamic> callListsApi() async {
    final res = await (widget.client as WixClient).fetchStaticLists();
    logger.d('[ApiCalls.callListsApi] _selectedListsOperation: $_selectedListsOperation');
    switch (_selectedListsOperation) {
      case 'users':
        return res['user'];
      case 'listsValues':
        final listName = params['staticLists_listsValues']!['listName'];
        return listName != null
            ? res['listValue']!.where((value) => value['type'] == listName).toList()
            : res['listValue'];
      case 'users&ListsValues':
        return res;
      default:
        throw Exception('Unknown operation for lists: $_selectedListsOperation');
    }
  }
}

// Future<dynamic> callImagesApi() async {
//   if (_selectedImageOperation == 'generateUploadUrl') {
//     return await (widget.client as WixClient).generateUploadUrl(fileName: 'file1');
//   }
//   throw Exception('Unknown operation for lists: $_selectedItemOperation');
// }

class _ApiCall {
  final String itemType;
  final String operation;
  final dynamic result;

  _ApiCall({required this.itemType, required this.operation, required this.result});

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

class _ListsValuesParams extends StatefulWidget {
  final String listName;
  final ValueChanged<String?> onChanged;

  const _ListsValuesParams({required this.listName, required this.onChanged});

  @override
  State<_ListsValuesParams> createState() => _ListsValuesParamsState();
}

class _ListsValuesParamsState extends State<_ListsValuesParams> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('List Name: ${widget.listName}'),
        Dropdown(items: _listNames, selectedItem: widget.listName, onChanged: widget.onChanged),
      ],
    );
  }
}
