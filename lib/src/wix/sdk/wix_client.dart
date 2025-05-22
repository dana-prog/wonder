import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wonder/src/data/metadata.dart';
import 'package:wonder/src/wix/sdk/token.dart';
import 'package:wonder/src/wix/sdk/wix_authentication.dart';

import '../../data/item.dart';
import '../../logger.dart';

enum _HeaderContentType {
  json,
  formUrlEncoded;

  @override
  String toString() {
    switch (this) {
      case _HeaderContentType.json:
        return 'application/json';
      case _HeaderContentType.formUrlEncoded:
        return 'application/x-www-form-urlencoded';
    }
  }
}

class WixClient {
  final authentication = WixAuthentication();
  final _metadata = Metadata();
  final _cache = _Cache();

  WixClient();

  Future<T> fetchItem<T extends Item>({
    required String itemType,
    required String id,
  }) async {
    logger.t('[WixClient.fetchItem] $itemType/$id');

    if (_cache.exists(id)) {
      return _cache[id] as T;
    }

    final itemMetadata = _metadata.getByName(itemType);

    await _ensureMemberLogin();

    final response = await http.get(
      Uri.parse('https://www.wixapis.com/wix-data/v2/items/$id?dataCollectionId=${itemMetadata.dataCollectionId}'),
      headers: _getHeaders(),
    );

    if (response.statusCode != 200) {
      throw Exception('[WixClient.fetchItem] Failed to fetch $itemType: ${response.body}');
    }

    logger.t('[WixClient.fetchItem] response.body: ${response.body}');

    final dataItem = jsonDecode(response.body)['dataItem'];
    return getItemObject(dataItem) as T;
  }

  Future<List<T>> fetchItems<T extends Item>({
    required String itemType,
  }) async {
    logger.t('[WixClient.fetchItems] $itemType');

    final itemMetadata = _metadata.getByName(itemType);

    await _ensureMemberLogin();

    final response = await http.post(
      Uri.parse('https://www.wixapis.com/wix-data/v2/items/query'),
      headers: _getHeaders(),
      body: jsonEncode({
        'dataCollectionId': itemMetadata.dataCollectionId,
        'query': {
          'sort': itemMetadata.defaultSortBy.map((e) => {'fieldName': e.$1, 'order': e.$2.toString()}).toList()
        },
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('[WixClient.fetchItems] Failed to fetch $itemType: ${response.body}');
    }

    logger.t('[WixClient.fetchItems] response.body: ${response.body}');

    return (jsonDecode(response.body)['dataItems'] as List)
        .cast<Map<String, dynamic>>()
        .map((dataItem) => getItemObject(dataItem) as T)
        .toList();
  }

  Future<T> updateItem<T extends Item>(T item) async {
    logger.t('[WixClient.updateItem] item: $item');

    await _ensureMemberLogin();

    final response = await http.put(
      Uri.parse('https://www.wixapis.com/wix-data/v2/items/${item.id}'),
      headers: _getHeaders(),
      body: jsonEncode({
        'dataCollectionId': item.itemType.pluralName,
        'dataItem': {'data': item.fields},
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('[WixClient.updateItem] Failed to updateItem $item: ${response.body}');
    }

    logger.t('[WixClient.updateItem] response.body: ${response.body}');

    final dataItem = jsonDecode(response.body)['dataItem'];
    return getItemObject(dataItem) as T;
  }

  Item getItemObject(Map<String, dynamic> dataItem) {
    final id = dataItem['id'];
    final dataCollectionId = dataItem['dataCollectionId'];
    final itemMetadata = _metadata.getByCollectionId(dataCollectionId);
    if (!_cache.exists(id)) {
      _cache.add(itemMetadata.constructor({
        'id': dataItem['id'],
        'itemType': itemMetadata.name,
      }));
    }

    final item = _cache[id];
    final data = dataItem['data'] as Map<String, dynamic>;

    for (var entry in data.entries) {
      item[entry.key] = entry.value;
    }

    return item;
  }

  Map<String, String> _getHeaders({_HeaderContentType contentType = _HeaderContentType.json}) => {
        'Authorization': _userAuth,
        'Content-Type': contentType.toString(),
      };

  String get _userAuth {
    final accessToken = authentication.accessToken;
    if (accessToken == null) {
      throw Exception('Access token is null, please login first');
    }

    return 'Bearer $accessToken';
  }

  Future<void> _ensureMemberLogin() async {
    final loginState = await authentication.getLoginState();
    if (loginState == LoginState.loggedInAsMember) {
      return;
    }

    await authentication.login(GrantType.authorizationCode);
  }
}

class _Cache {
  static final _Cache _instance = _Cache._internal();

  factory _Cache() {
    return _instance;
  }

  _Cache._internal();

  final Map<String, Item> _itemsById = {};

  bool exists(String id) {
    return _itemsById.containsKey(id);
  }

  dynamic operator [](String id) {
    return _itemsById.containsKey(id)
        ? _itemsById[id]
        : throw Exception(
            "Item with id $id not found in cache",
          );
  }

  void add(Item item) {
    _itemsById[item.id] = item;
  }

  void clear() => _itemsById.clear();
}
