import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wonder/src/wix/sdk/token.dart';
import 'package:wonder/src/wix/sdk/wix_authentication.dart';

import '../../data/item.dart';
import '../../logger.dart';

class WixClient {
  final authentication = WixAuthentication();

  Future<List<Item>> fetchFacilities() async {
    return fetchItems('facilities');
  }

  Future<List<Item>> fetchItems(String itemType) async {
    logger.d('[WixClient.fetchItems] itemType: $itemType');

    await _ensureLoggedInAsMember();

    final response = await http.post(
      Uri.parse('https://www.wixapis.com/wix-data/v2/items/query'),
      headers: _httpHeaders,
      body: jsonEncode({
        'dataCollectionId': itemType,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch $itemType: ${response.body}');
    }

    logger.d('[WixClient.fetchItems] response.body: ${response.body}');

    return jsonDecode(response.body)['dataItems'].map<Item>((dataItem) {
      return Item({
        'id': dataItem['id'],
        'dataCollectionId': dataItem['dataCollectionId'],
        ...dataItem['data'],
      });
    }).toList();
  }

  Future<void> _ensureLoggedInAsMember() async {
    final loginState = await authentication.getLoginState();
    if (loginState == LoginState.loggedInAsMember) {
      return;
    }

    await authentication.login(GrantType.authorizationCode);
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
}
