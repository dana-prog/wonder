import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wonder/src/wix/sdk/token.dart';
import 'package:wonder/src/wix/sdk/wix_authentication.dart';

import '../../data/data_item.dart';
import '../../logger.dart';

enum SortOrder {
  ascending,
  descending;

  @override
  String toString() {
    switch (this) {
      case SortOrder.ascending:
        return 'ASC';
      case SortOrder.descending:
        return 'DESC';
    }
  }
}

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

  WixClient();

  Future<List<T>> fetchItems<T extends DataItem>({
    required String dataCollectionId,
    required T Function(Map<String, dynamic>) itemConstructor,
    List<(String, SortOrder?)>? sortBy,
  }) async {
    logger.t('[WixClient.fetchItems] itemType: $dataCollectionId');

    await _ensureMemberLogin();

    final response = await http.post(
      Uri.parse('https://www.wixapis.com/wix-data/v2/items/query'),
      headers: _getHeaders(),
      body: jsonEncode({
        'dataCollectionId': dataCollectionId,
        'query': {
          'sort': sortBy
              ?.map((e) => {
                    'fieldName': e.$1,
                    'order': (e.$2 ?? SortOrder.ascending).toString(),
                  })
              .toList(),
        }
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('[WixClient.fetchItems] Failed to fetch $dataCollectionId: ${response.body}');
    }

    logger.t('[WixClient.fetchItems] response.body: ${response.body}');

    return (jsonDecode(response.body)['dataItems'] as List)
        .cast<Map<String, dynamic>>()
        .map((dataItem) => itemConstructor({
              'id': dataItem['id'],
              'dataCollectionId': dataItem['dataCollectionId'],
              ...(dataItem['data'] as Map<String, dynamic>),
            }))
        .toList();
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
