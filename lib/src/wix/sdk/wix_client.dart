import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wonder/src/data/value_item.dart';
import 'package:wonder/src/wix/sdk/token.dart';
import 'package:wonder/src/wix/sdk/wix_authentication.dart';

import '../../data/data_item.dart';
import '../../logger.dart';

class WixClient {
  final authentication = WixAuthentication();
  final listsOfValues = Completer<ListsOfValues>();
  final members = Completer<ListsOfValues>();
  bool _listsInitialized = false;

  WixClient();

  Future<List<T>> fetchDataItems<T extends DataItem>(
    String type,
    T Function(Map<String, dynamic>, ListsOfValues listsOfValues) itemConstructor,
  ) async {
    logger.t('[WixClient.fetchDataItems] fetching $type items');

    await _ensureMemberLogin();
    await _ensureListsInitialized();

    logger.t('[WixClient.fetchDataItems] ensured member login and lists initialized');

    final itemsFields = await _fetchItemsFields(type);
    final lists = await listsOfValues.future;
    final items = itemsFields.map<T>((fields) => itemConstructor(fields, lists)).toList();
    logger.d('[WixClient.fetchDataItems] fetched ${items.length} items: $items');
    return items;
  }

  Future<List<ValueItem>> _fetchValueItems() async {
    logger.t('[WixClient._fetchValueItems] fetching value items');

    final itemsFields = await _fetchItemsFields('lists_of_values');
    final items = itemsFields.map<ValueItem>((fields) => ValueItem(fields)).toList();
    logger.d('[WixClient._fetchValueItems] fetched ${items.length} items: $items');
    return items;
  }

  Future<List<Map<String, dynamic>>> _fetchItemsFields(String dataCollectionId) async {
    logger.t('[WixClient._fetchItemsFields] itemType: $dataCollectionId');

    final response = await http.post(
      Uri.parse('https://www.wixapis.com/wix-data/v2/items/query'),
      headers: _httpHeaders,
      body: jsonEncode({
        'dataCollectionId': dataCollectionId,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch $dataCollectionId: ${response.body}');
    }

    logger.t('[WixClient._fetchItemsFields] response.body: ${response.body}');

    return (jsonDecode(response.body)['dataItems'] as List)
        .cast<Map<String, dynamic>>()
        .map((dataItem) => {
              'id': dataItem['id'],
              'dataCollectionId': dataItem['dataCollectionId'],
              ...(dataItem['data'] as Map<String, dynamic>),
            })
        .toList();
  }

  Map<String, String> get _httpHeaders {
    final accessToken = authentication.accessToken;
    if (accessToken == null) {
      throw Exception('Access token is null, please login first');
    }

    return {
      'Authorization': 'Bearer ${authentication.accessToken}',
      'Content-Type': 'application/json',
    };
  }

  Future<void> _ensureMemberLogin() async {
    final loginState = await authentication.getLoginState();
    if (loginState == LoginState.loggedInAsMember) {
      return;
    }

    await authentication.login(GrantType.authorizationCode);
  }

  Future<void> _ensureListsInitialized() async {
    if (_listsInitialized) {
      return;
    }

    final lists = await _fetchValueItems();
    listsOfValues.complete(ListsOfValues(lists));
    _listsInitialized = true;
  }
}
