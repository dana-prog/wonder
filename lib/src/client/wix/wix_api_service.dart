import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../data/item.dart';
import '../../data/metadata.dart';
import '../../logger.dart';
import '../token.dart';
import 'wix_utils.dart';

const _clientId = '1ac77337-faee-4233-8f67-d700faa547da';
const _scheme = 'https';
const _host = 'www.wixapis.com';

abstract class WixRestEndpoint<T> {
  final String methodType;
  final String path;
  final String? accessToken;
  final Map<String, dynamic>? queryParams;
  final Map<String, dynamic>? body;
  final T Function(String responseBodyStr) responseBodyFormatter;

  const WixRestEndpoint({
    required this.path,
    required this.methodType,
    this.accessToken,
    this.queryParams,
    this.body,
    required this.responseBodyFormatter,
  });

  Future<T> call() async {
    String? bodyStr = body != null ? jsonEncode(body) : null;

    logger.t('''[WixRestEndpoint.call] 
      uri: $uri
      headers: $headers
      method: $methodType
      request body: $bodyStr
     ''');

    final response = await _call(uri, headers: headers, body: bodyStr);

    if (response.statusCode != 200) {
      throw Exception('''Error when calling wix api:
      statusCode: ${response.statusCode}
      response.body: ${response.body}''');
    }

    final formattedResponse = responseBodyFormatter(response.body);
    logger.t('''[WixRestEndpoint.call] 
      uri: $uri
      response body: ${response.body}
      formattedResponse: $formattedResponse''');

    return formattedResponse;
  }

  Future<http.Response> _call(Uri url, {Map<String, String>? headers, String? body}) async {
    switch (methodType) {
      case 'GET':
        return await http.get(uri, headers: headers);
      case 'POST':
        return await http.post(uri, headers: headers, body: body);
      case 'PUT':
        return await http.put(uri, headers: headers, body: body);
      case 'DELETE':
        return await http.delete(uri, headers: headers, body: body);
      default:
        throw Exception('Unexpected methodType: $methodType');
    }
  }

  Uri get uri => Uri(scheme: _scheme, host: _host, path: path, queryParameters: queryParams);

  Map<String, String> get headers {
    final headers = <String, String>{};
    headers['Content-Type'] = 'application/json';
    if (accessToken != null) {
      headers['Authorization'] = 'Bearer $accessToken';
    }

    return headers;
  }
}

class GenerateAnonymousTokenEndpoint extends WixRestEndpoint<Token> {
  GenerateAnonymousTokenEndpoint()
      : super(
          path: 'oauth2/token',
          methodType: 'POST',
          body: {'grant_type': 'anonymous', 'client_id': _clientId},
          responseBodyFormatter: _ResponseBodyFormatters.toAnonymousToken,
        );
}

class GenerateMemberTokenEndpoint extends WixRestEndpoint<Token> {
  GenerateMemberTokenEndpoint(
      {required String redirectUri, required String code, required String codeVerifier})
      : super(
          path: 'oauth2/token',
          methodType: 'POST',
          body: {
            'code': code,
            'codeVerifier': codeVerifier,
            'clientId': _clientId,
            'redirectUri': redirectUri,
            'grantType': 'authorization_code',
          },
          responseBodyFormatter: _ResponseBodyFormatters.toMemberToken,
        );
}

class RenewTokenEndpoint extends WixRestEndpoint<Token> {
  RenewTokenEndpoint({required Token token})
      : super(
          path: 'oauth2/token',
          methodType: 'POST',
          body: {
            'grant_type': 'refresh_token',
            'client_id': _clientId,
            'refresh_token': token.refreshToken
          },
          responseBodyFormatter: token.grantType == GrantType.anonymous
              ? _ResponseBodyFormatters.toAnonymousToken
              : _ResponseBodyFormatters.toMemberToken,
        );
}

class FetchLoginUrlEndpoint extends WixRestEndpoint<String> {
  FetchLoginUrlEndpoint({
    required super.accessToken,
    String? redirectUri,
    required String codeChallenge,
    required String state,
  }) : super(
          path: '_api/redirects-api/v1/redirect-session',
          methodType: 'POST',
          body: {
            'auth': {
              'authRequest': {
                'codeChallenge': codeChallenge,
                'state': state,
                'clientId': _clientId,
                'redirectUri': redirectUri,
                'codeChallengeMethod': 'S256',
                // TODO: check other options for responseMode, responseType and scope
                'responseType': 'code',
                'responseMode': 'fragment',
                // offline_access allows the app to receive a refresh token
                'scope': 'offline_access',
              },
            },
          },
          responseBodyFormatter: _ResponseBodyFormatters.toRedirectUrl,
        );
}

class FetchLogoutUrlEndpoint extends WixRestEndpoint<String> {
  FetchLogoutUrlEndpoint({super.accessToken})
      : super(
          path: '_api/redirects-api/v1/redirect-session',
          methodType: 'POST',
          body: {
            'logout': {'clientId': _clientId},
          },
          responseBodyFormatter: _ResponseBodyFormatters.toRedirectUrl,
        );
}

// class LoginEndpoint extends WixRestEndpoint<String> {
//   final String email;
//   final String password;
//
//   LoginEndpoint({
//     required super.accessToken,
//     required this.email,
//     required this.password,
//   }) : super(
//           path: '_api/iam/authentication/v2/login',
//           methodType: 'POST',
//           body: {
//             'loginId': {
//               'email': email,
//             },
//             'password': password,
//           },
//           responseBodyFormatter: _ResponseBodyFormatters.toSessionToken,
//         );
// }

class FetchItemEndpoint<T extends Item> extends WixRestEndpoint<T> {
  FetchItemEndpoint({required super.accessToken, required String itemType, required String id})
      : super(
          path: 'wix-data/v2/items/$id',
          methodType: 'GET',
          queryParams: {'dataCollectionId': Metadata().getByName(itemType).dataCollectionId},
          responseBodyFormatter: _ResponseBodyFormatters.toItem<T>,
        );
}

class FetchItemsEndpoint<T extends Item> extends WixRestEndpoint<List<T>> {
  FetchItemsEndpoint({required String accessToken, required String itemType})
      : super(
          path: ['user', 'listValue'].contains(itemType)
              ? 'velo/v1/http/invoke/${Metadata().getByName(itemType).dataCollectionId}'
              : 'wix-data/v2/items/query',
          methodType: 'POST',
          accessToken: accessToken,
          body: {
            'dataCollectionId': Metadata().getByName(itemType).dataCollectionId,
            'sort': Metadata()
                .getByName(itemType)
                .defaultSortBy
                .map((e) => {'fieldName': e.$1, 'order': e.$2.toString()})
                .toList(),
          },
          responseBodyFormatter: _ResponseBodyFormatters.toItems<T>,
        );
}

class CreateItemEndpoint<T extends Item> extends WixRestEndpoint<T> {
  final Map<String, dynamic> fields;

  CreateItemEndpoint({required super.accessToken, required this.fields})
      : super(
          path: 'wix-data/v2/items',
          methodType: 'POST',
          body: {
            'dataCollectionId': Metadata().getByName(fields['itemType']).dataCollectionId,
            'dataItem': {'data': fields},
          },
          responseBodyFormatter: _ResponseBodyFormatters.toItem<T>,
        );
}

class UpdateItemEndpoint<T extends Item> extends WixRestEndpoint<T> {
  UpdateItemEndpoint({required super.accessToken, required T item})
      : super(
          path: 'wix-data/v2/items/${item.id}',
          methodType: 'PUT',
          body: {
            'dataCollectionId': Metadata().getByName(item.itemType).dataCollectionId,
            'dataItem': {'data': item.fields},
          },
          responseBodyFormatter: _ResponseBodyFormatters.toItem<T>,
        );
}

class DeleteItemEndpoint<T extends Item> extends WixRestEndpoint<T> {
  DeleteItemEndpoint({required super.accessToken, required String itemType, required String id})
      : super(
          path: 'wix-data/v2/items/$id',
          methodType: 'DELETE',
          queryParams: {'dataCollectionId': Metadata().getByName(itemType).dataCollectionId},
          responseBodyFormatter: _ResponseBodyFormatters.toItem<T>,
        );
}

class GenerateUploadUrlEndpoint extends WixRestEndpoint<String> {
  GenerateUploadUrlEndpoint({
    required super.accessToken,
    required String fileName,
    String? folderPath,
  }) : super(
          path: 'site-media/v1/files/generate-upload-url',
          methodType: 'POST',
          body: {
            "mimeType": "image/jpeg",
            "fileName": "T-shirt.jpg",
            "sizeInBytes": "2608831",
            "parentFolderId": "25284aa06584441ea94338fdcfbaba12",
            "private": false,
            "labels": ["AMS:external_file_id", "woman", "bicycle"]
          },
          // {
          //           'fileName': fileName,
          //           // 'filePath': folderPath,
          //           'private': false,
          //         },
          responseBodyFormatter: _ResponseBodyFormatters.toUploadUrl,
        );
}

// class FetchUsersEndpoint extends WixRestEndpoint<List<UserItem>> {
//   FetchUsersEndpoint({required super.accessToken})
//       : super(
//           path: 'velo/v1/http/invoke/users',
//           methodType: 'GET',
//           responseBodyFormatter: _ResponseBodyFormatters.toItems<UserItem>,
//         );
// }

class FetchStaticListsEndpoint extends WixRestEndpoint<Map<String, List<Item>>> {
  FetchStaticListsEndpoint({required super.accessToken})
      : super(
          path: 'velo/v1/http/invoke/staticLists',
          methodType: 'GET',
          responseBodyFormatter: _ResponseBodyFormatters.toItemsLists,
        );
}

class _ResponseBodyFormatters {
  static Token toAnonymousToken(String bodyStr) =>
      _responseBodyToToken(GrantType.anonymous, bodyStr);

  static Token toMemberToken(String bodyStr) => _responseBodyToToken(GrantType.member, bodyStr);

  static String toRedirectUrl(String bodyStr) {
    final Map<String, dynamic> responseBody = jsonDecode(bodyStr);
    return responseBody['redirectSession']['fullUrl'] as String;
  }

  static T toItem<T extends Item>(String bodyStr) =>
      dataItemToItem(jsonDecode(bodyStr)['dataItem']);

  static List<T> toItems<T extends Item>(String bodyStr) {
    List<Map<String, dynamic>> dataItems =
        (jsonDecode(bodyStr)['dataItems'] as List).cast<Map<String, dynamic>>();
    return dataItems.map<T>((dataItem) => dataItemToItem<T>(dataItem)).toList();
  }

  static Map<String, List<Item>> toItemsLists(String bodyStr) {
    final lists = <String, List<Item>>{};

    for (final MapEntry entry in jsonDecode(bodyStr).entries) {
      final String itemType = Metadata().getByCollectionId(entry.key).name;
      lists[itemType] = (entry.value as List)
          .map((dataItem) => dataItemToItem<Item>(dataItem as Map<String, dynamic>))
          .toList();
    }

    return lists;
  }

  static String toUploadUrl(String bodyStr) {
    final Map<String, dynamic> responseBody = jsonDecode(bodyStr);
    return responseBody['uploadUrl'] as String;
  }

  // static String toSessionToken(String bodyStr) {
  //   final Map<String, dynamic> responseBody = jsonDecode(bodyStr);
  //   return responseBody['sessionToken'] as String;
  // }

  static Token _responseBodyToToken(GrantType grantType, String bodyStr) {
    logger.t('[WixRestApi._responseBodyToToken] bodyStr: $bodyStr');
    final Map<String, dynamic> body = jsonDecode(bodyStr);
    return Token(
      grantType: grantType,
      accessToken: body['access_token'] as String,
      refreshToken: body['refresh_token'] as String,
      expiresAt: DateTime.now().add(Duration(seconds: body['expires_in'] as int)),
    );
  }
}
