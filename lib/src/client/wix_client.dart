import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../data/item.dart';
import '../logger.dart';
import 'client.dart';
import 'token.dart';
import 'wix_authentication.dart';

const _itemsApiBaseUrl = 'https://www.wixapis.com/wix-data/v2/items';

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

// TODO: move to server or to item initialization in the client
final defaultFieldValues = {
  'facility': {'type': 'd9c1d2a1-17fe-4f3f-b035-dcbe4905e444'}
};

// TODO: separate the authentication and db apis
class WixClient extends Client {
  final _authentication = WixAuthentication();

  WixClient() {
    logger.d('[WixClient]');
  }

  @override
  Future<T> fetchItem<T extends Item>({
    required String itemType,
    required String id,
  }) async {
    logger.t('[WixClient.fetchItem] $itemType/$id');

    if (cache.exists(id)) {
      return cache[id] as T;
    }

    final itemMetadata = metadata.getByName(itemType);

    await _ensureMemberLogin();

    final response = await http.get(
      Uri.parse('$_itemsApiBaseUrl/$id?dataCollectionId=${itemMetadata.dataCollectionId}'),
      headers: _getHeaders(),
    );

    if (response.statusCode != 200) {
      throw Exception('[WixClient.fetchItem] Failed to fetch $itemType: ${response.body}');
    }

    logger.t('[WixClient.fetchItem] response.body: ${response.body}');

    final dataItem = jsonDecode(response.body)['dataItem'];
    return getItemObject(dataItem) as T;
  }

  @override
  Future<List<T>> fetchItems<T extends Item>({
    required String itemType,
  }) async {
    logger.t('[WixClient.fetchItems] $itemType');

    final itemMetadata = metadata.getByName(itemType);

    await _ensureMemberLogin();

    final response = await http.post(
      Uri.parse('$_itemsApiBaseUrl/query'),
      headers: _getHeaders(),
      body: jsonEncode({
        'dataCollectionId': itemMetadata.dataCollectionId,
        'query': {
          'sort': itemMetadata.defaultSortBy
              .map((e) => {'fieldName': e.$1, 'order': e.$2.toString()})
              .toList()
        },
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('[WixClient.fetchItems] Failed to fetch $itemType: ${response.body}');
    }

    logger.t('[WixClient.fetchItems] response.body: ${response.body}');

    return (jsonDecode(response.body)['dataItems'] as List)
        .cast<Map<String, dynamic>>()
        .map((dataItem) => getItemObject<T>(dataItem))
        .toList();
  }

  @override
  Future<T> addItem<T extends Item>(Map<String, dynamic> fields) async {
    logger.d('[WixClient.addItem] $fields');

    await _ensureMemberLogin();

    final dataCollectionId = metadata.getByName(fields['itemType']).dataCollectionId;
    final response = await http.post(
      Uri.parse(_itemsApiBaseUrl),
      headers: _getHeaders(),
      body: jsonEncode({
        'dataCollectionId': dataCollectionId,
        'dataItem': {
          'data': {
            ...defaultFieldValues[fields['itemType']] ?? {},
            ...fields,
          }
        },
      }),
    );

    logger.d('[WixClient.createItem] ${response.statusCode}\n${response.body}');

    if (response.statusCode != 200) {
      throw Exception('[WixClient.updateItem] Failed to update item $fields: ${response.body}');
    }

    return super.addItem(jsonDecode(response.body)['dataItem']);
  }

  @override
  Future<T> updateItem<T extends Item>(T newItem) async {
    await _ensureMemberLogin();

    final fields = newItem.fields;
    fields.removeWhere((fieldName, _) => ['id', 'itemType'].contains(fieldName));
    final dataCollectionId = metadata.getByName(newItem.itemType).dataCollectionId;
    final response = await http.put(
      Uri.parse('$_itemsApiBaseUrl/${newItem.id}'),
      headers: _getHeaders(),
      body: jsonEncode({
        'dataCollectionId': dataCollectionId,
        'dataItem': {'data': fields},
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('[WixClient.updateItem] Failed to update item $newItem: ${response.body}');
    }

    final dataItem = jsonDecode(response.body)['dataItem'];
    final item = getItemObject(dataItem) as T;
    return super.updateItem(item);
  }

  @override
  Future<T> deleteItem<T extends Item>(T item) async {
    logger.t('[WixClient.deleteItem] $item');

    await _ensureMemberLogin();

    final id = item.id;
    final dataCollectionId = metadata.getByName(item.itemType).dataCollectionId;
    final response = await http.delete(
      Uri.parse('$_itemsApiBaseUrl/$id?dataCollectionId=$dataCollectionId'),
      headers: _getHeaders(),
    );

    if (response.statusCode != 200) {
      throw Exception('[WixClient.deleteItem] Failed to delete item $item: ${response.body}');
    }

    T i = getItemObject<T>(jsonDecode(response.body)['dataItem']);
    return super.deleteItem(i);
  }

  Map<String, String> _getHeaders({_HeaderContentType contentType = _HeaderContentType.json}) => {
        'Authorization': _apiKeyAuth,
        'wix-site-id': _siteId,
        'Content-Type': contentType.toString(),
      };

  // String get _userAuth {
  //   final accessToken = _authentication.accessToken;
  //   if (accessToken == null) {
  //     throw Exception('Access token is null, please login first');
  //   }
  //
  //   return 'Bearer $accessToken';
  // }

  String get _siteId => 'd03a309f-520f-4b7e-9162-dbb99244ceb7';

  String get _apiKeyAuth =>
      'IST.eyJraWQiOiJQb3pIX2FDMiIsImFsZyI6IlJTMjU2In0.eyJkYXRhIjoie1wiaWRcIjpcIjEyZjhlMWQ1LTRmOWQtNDM0Ni1hNzk4LTA2ZGE1MjFhMzRmNVwiLFwiaWRlbnRpdHlcIjp7XCJ0eXBlXCI6XCJhcHBsaWNhdGlvblwiLFwiaWRcIjpcIjk2NDlhYWM2LTgwMzAtNDlmMy1iMmYzLTBjNTFiYTk5ZTY3MlwifSxcInRlbmFudFwiOntcInR5cGVcIjpcImFjY291bnRcIixcImlkXCI6XCIxMjQ2ZmU0ZC1jMmU0LTQwNmItOWNiOS1iMmZlZGJmNTJjM2RcIn19IiwiaWF0IjoxNzQ3NDE5NDI1fQ.fxH6Kq8Udf9N_2eXS0l0Zd9ahNldSxleA8KHwCpOSo-yhMiD2pdJN4d3sVVED-vY_r8OF9Z7QzslNv8OSLuRvdadEPkdP6xatVCQ4U72TOnK-NAzStftyBJ5TsDCJRL-wsKqQ8Q29ZTgWMCBBLnmAJS0pGLZ6QLcaA1DWRK6SwhpKf3TBjqY7QmUG0TtdUQsfiaKxlZn0U2EjFz5A-yDQZ4UaV9k5Rb8LTaZTyJxxymPhOJVYeZdQ5ej3U6mwSuxhPpS7S6G6XN77CLsTU7iODb5PPrIkSF3nllZ4H2x_Q4FL5IIjDnqvkjit8hMi-fQBjP8uMIQR5MsoYn3Q9Zx_Q';

  Future<void> _ensureMemberLogin() async {
    final loginState = await _authentication.getLoginState();
    if (loginState == LoginState.loggedInAsMember) {
      return;
    }

    await _authentication.login(GrantType.authorizationCode);
  }

  @override
  void printCachedItems() {
    final itemFields = cache.itemsById.values.map((item) {
      final fields = item.fields;
      fields.removeWhere((fieldName, fieldValue) => fieldName.startsWith('_'));
      return fields;
    }).toList();
    final str = jsonEncode(itemFields);
    logger.i(str);
  }

  @override
  Future<void> printMyMember() async {
    final member = await _authentication.getMyMember();
    if (member == null) {
      logger.w('No current member found');
      return;
    }

    logger.i('[WixClient.printMyMember] response: $member');
  }

  @override
  Future<void> logout() async => await _authentication.logout();

  @override
  T getItemObject<T extends Item>(Map<String, dynamic> fields) {
    final id = fields['id'];
    final dataCollectionId = fields['dataCollectionId'];
    final itemMetadata = metadata.getByCollectionId(dataCollectionId);
    return super.getItemObject({
      'id': id,
      'itemType': itemMetadata.name,
      ...fields['data'],
    });
  }
}
