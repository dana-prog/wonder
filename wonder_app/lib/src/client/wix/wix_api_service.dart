import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../data/file_item.dart';
import '../../data/item.dart';
import '../../data/metadata.dart';
import '../../logger.dart';
import '../../storage/file_storage_plugin.dart';
import '../token.dart';
import 'wix_utils.dart';

const _clientId = '1ac77337-faee-4233-8f67-d700faa547da';
const _scheme = 'https';
const _host = 'www.wixapis.com';

class HeaderNames {
  static final contentType = 'Content-Type';
  static final authorization = 'Authorization';
}

abstract class WixRestEndpoint<T> {
  final String methodType;
  final String path;
  final String? accessToken;
  final Map<String, dynamic>? queryParams;
  final dynamic body;
  final String contentType;
  final T Function(String responseBodyStr) responseBodyFormatter;

  const WixRestEndpoint({
    required this.path,
    required this.methodType,
    this.contentType = 'application/json',
    this.accessToken,
    this.queryParams,
    this.body,
    required this.responseBodyFormatter,
  });

  Future<T> call() async {
    logger.t('[WixRestEndpoint.call] uri: $uri\n'
        'methodType: $methodType\n'
        'headers: $headers\n'
        'body: $body\n');

    final response = await sendRequest();

    if (response.statusCode != 200) {
      final errorData = {
        'statusCode': response.statusCode,
        'reasonPhrase': response.reasonPhrase,
        'uri': uri.toString(),
        'headers': response.headers,
        'body': response.body,
      };
      logger.e('[WixRestEndpoint.call] Error:\n${JsonEncoder.withIndent('  ').convert(errorData)}');
    }

    final formattedResponse = responseBodyFormatter(response.body);
    logger.t('''[WixRestEndpoint.call] 
      uri: $uri
      response body: ${response.body}
      formattedResponse: $formattedResponse''');

    return formattedResponse;
  }

  @protected
  Future<http.Response> sendRequest();

  Uri get uri => Uri(scheme: _scheme, host: _host, path: path, queryParameters: queryParams);

  dynamic get requestBody {
    if (contentType == 'application/json' && body != null) {
      return jsonEncode(body);
    }
    return body;
  }

  @protected
  String authorizationHeader() {
    if (accessToken != null) {
      return 'Bearer $accessToken';
    }
    return '';
  }

  Map<String, String> get headers {
    final headers = <String, String>{};
    headers[HeaderNames.contentType] = 'application/json';
    if (accessToken != null) {
      headers[HeaderNames.authorization] = authorizationHeader();
    }

    return headers;
  }
}

abstract class WixRawRequestEndpoint<T> extends WixRestEndpoint<T> {
  const WixRawRequestEndpoint({
    required super.path,
    required super.methodType,
    required super.responseBodyFormatter,
    super.contentType,
    super.accessToken,
    super.queryParams,
    super.body,
  }) : super();

  @override
  Future<http.Response> sendRequest() async {
    switch (methodType) {
      case 'GET':
        return await http.get(uri, headers: headers);
      case 'POST':
        return await http.post(uri, headers: headers, body: requestBody);
      case 'PUT':
        return await http.put(uri, headers: headers, body: requestBody);
      case 'DELETE':
        return await http.delete(uri, headers: headers, body: requestBody);
      default:
        throw Exception('Unexpected methodType: $methodType');
    }
  }
}

abstract class WixStreamedRequestEndpoint<T> extends WixRestEndpoint<T> {
  final Stream<Uint8List> stream;

  const WixStreamedRequestEndpoint({
    required super.path,
    // required super.methodType,
    required super.responseBodyFormatter,
    required this.stream,
    super.contentType,
    super.accessToken,
    super.queryParams,
  }) : super(methodType: 'PUT');

  @override
  Future<http.Response> sendRequest() async {
    final byteStream = http.ByteStream(stream);
    final request = http.StreamedRequest(methodType, uri);
    request.headers.addAll(headers);

    logger.t('[WixStreamedRequestEndpoint.sendRequest] 1');
    try {
      await byteStream.pipe(request.sink);
    } catch (e) {
      logger.e('[WixStreamedRequestEndpoint.sendRequest] Error while piping stream');
      rethrow;
    }
    logger.t('[WixStreamedRequestEndpoint.sendRequest] 2');

    final streamedResponse = await request.send();
    logger.t('[WixStreamedRequestEndpoint.sendRequest] 3');
    logger.d('[WixStreamedRequestEndpoint.sendRequest] '
        'Response status: ${streamedResponse.statusCode} ${streamedResponse.reasonPhrase}');
    return http.Response.fromStream(streamedResponse);
  }
}

class GenerateAnonymousTokenEndpoint extends WixRawRequestEndpoint<Token?> {
  GenerateAnonymousTokenEndpoint()
      : super(
          path: 'oauth2/token',
          methodType: 'POST',
          body: {'grant_type': 'anonymous', 'client_id': _clientId},
          responseBodyFormatter: ResponseBodyFormatters.toAnonymousToken,
        );
}

class GenerateMemberTokenEndpoint extends WixRawRequestEndpoint<Token?> {
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
          responseBodyFormatter: ResponseBodyFormatters.toMemberToken,
        );
}

class RenewTokenEndpoint extends WixRawRequestEndpoint<Token?> {
  RenewTokenEndpoint({required Token token})
      : super(
          path: 'oauth2/token',
          methodType: 'POST',
          accessToken: token.accessToken,
          body: {
            'grant_type': 'refresh_token',
            'client_id': _clientId,
            'refresh_token': token.refreshToken
          },
          responseBodyFormatter: token.grantType == GrantType.anonymous
              ? ResponseBodyFormatters.toAnonymousToken
              : ResponseBodyFormatters.toMemberToken,
        );
}

class FetchLoginUrlEndpoint extends WixRawRequestEndpoint<String> {
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
          responseBodyFormatter: ResponseBodyFormatters.toRedirectUrl,
        );
}

class FetchLogoutUrlEndpoint extends WixRawRequestEndpoint<String> {
  FetchLogoutUrlEndpoint({super.accessToken})
      : super(
          path: '_api/redirects-api/v1/redirect-session',
          methodType: 'POST',
          body: {
            'logout': {'clientId': _clientId},
          },
          responseBodyFormatter: ResponseBodyFormatters.toRedirectUrl,
        );
}

class FetchItemEndpoint<T extends Item> extends WixRawRequestEndpoint<T> {
  FetchItemEndpoint({required super.accessToken, required String itemType, required String id})
      : super(
          path: 'wix-data/v2/items/$id',
          methodType: 'GET',
          queryParams: {'dataCollectionId': Metadata().getByName(itemType).dataCollectionId},
          responseBodyFormatter: ResponseBodyFormatters.toItem<T>,
        );
}

class FetchItemsEndpoint<T extends Item> extends WixRawRequestEndpoint<List<T>> {
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
          responseBodyFormatter: ResponseBodyFormatters.toItems<T>,
        );
}

class CreateItemEndpoint<T extends Item> extends WixRawRequestEndpoint<T> {
  final Map<String, dynamic> fields;

  CreateItemEndpoint({required super.accessToken, required this.fields})
      : super(
          path: 'wix-data/v2/items',
          methodType: 'POST',
          body: {
            'dataCollectionId': Metadata().getByName(fields['itemType']).dataCollectionId,
            'dataItem': {'data': fields},
          },
          responseBodyFormatter: ResponseBodyFormatters.toItem<T>,
        );
}

class UpdateItemEndpoint<T extends Item> extends WixRawRequestEndpoint<T> {
  UpdateItemEndpoint({required super.accessToken, required T item})
      : super(
          path: 'wix-data/v2/items/${item.id}',
          methodType: 'PUT',
          body: {
            'dataCollectionId': Metadata().getByName(item.itemType).dataCollectionId,
            'dataItem': {'data': item.fields},
          },
          responseBodyFormatter: ResponseBodyFormatters.toItem<T>,
        );
}

class DeleteItemEndpoint<T extends Item> extends WixRawRequestEndpoint<T> {
  DeleteItemEndpoint({required super.accessToken, required String itemType, required String id})
      : super(
          path: 'wix-data/v2/items/$id',
          methodType: 'DELETE',
          queryParams: {'dataCollectionId': Metadata().getByName(itemType).dataCollectionId},
          responseBodyFormatter: ResponseBodyFormatters.toItem<T>,
        );
}

class FetchStaticListsEndpoint extends WixRawRequestEndpoint<Map<String, List<Item>>> {
  FetchStaticListsEndpoint({required super.accessToken})
      : super(
          path: 'velo/v1/http/invoke/static_lists',
          // TODO: should we change to POST? (like all collections)
          methodType: 'GET',
          responseBodyFormatter: ResponseBodyFormatters.toItemsLists,
        );
}

class GenerateUploadUrlEndpoint extends WixRawRequestEndpoint<String> {
  GenerateUploadUrlEndpoint({
    required super.accessToken,
    required String fileName,
    required String mimeType,
    required FileContext context,
  }) : super(
            path: 'velo/v1/http/invoke/generate_upload_url',
            methodType: 'POST',
            body: {
              'fileName': fileName,
              'mimeType': mimeType,
              'context': {
                'dataCollectionId': Metadata().getByName(context.itemType).dataCollectionId,
                'itemId': context.itemId,
                'fieldName': context.fieldName,
              }
            },
            responseBodyFormatter: (String url) {
              if (url.isEmpty) {
                logger.w(
                    '[GenerateUploadUrlEndpoint.responseBodyFormatter] Response has an empty body - returning an empty upload url');
                return '';
              }

              return url;
            });
}

class GenerateDownloadUrlEndpoint extends WixRawRequestEndpoint<String> {
  GenerateDownloadUrlEndpoint({
    required super.accessToken,
    required String fileUrl,
    // assetKey specifies which version (asset) of the file you want to download
    // A "file" in Wix can have multiple assets—for example:
    // - The original format (default, "src")
    // - Resized versions (e.g. "thumbnail")
    // - Different encodings or sizes depending on mediaType
    // List<String>? assetKeys,
  }) : super(
            path: 'velo/v1/http/invoke/generate_download_url',
            methodType: 'POST',
            body: {
              'fileUrl': fileUrl,
            },
            responseBodyFormatter: (String bodyStr) {
              if (bodyStr.isEmpty) {
                logger.w(
                    '[GenerateUploadUrlEndpoint.responseBodyFormatter] Response has an empty body - returning an empty upload url');
              }

              return bodyStr;
            });
}

class UploadedFileProps {
  final String fileName;
  final String originalFileName;
  final int width;
  final int height;

  UploadedFileProps({
    required this.fileName,
    required this.originalFileName,
    required this.width,
    required this.height,
  });
}

class UploadFileEndpoint extends WixRawRequestEndpoint<Map<String, dynamic>> {
  final String uploadUrl;
  final Uint8List fileBytes;
  final String fileName;
  final String mimeType;

  UploadFileEndpoint({
    required this.uploadUrl,
    required this.fileBytes,
    required this.fileName,
    required this.mimeType,
  }) : super(
          path: uploadUrl,
          contentType: 'multipart/form-data',
          methodType: 'POST',
          responseBodyFormatter: (bodyStr) {
            final json = jsonDecode(bodyStr);
            final fileData = json[0];
            final fileName = fileData['fileName'];
            final originalFileName = fileData['originalFileName'];
            final width = fileData['width'];
            final height = fileData['height'];

            final fileUrl =
                'wix:image://v1/$fileName/$originalFileName#originWidth=$width&originHeight=$height';

            return {
              ...fileData,
              'id': fileUrl,
              'fileUrl': fileUrl,
              'mimeType': mimeType,
            };
          },
        );

  @override
  Future<http.Response> sendRequest() async {
    final multipartFile = http.MultipartFile.fromBytes(
      'file',
      fileBytes,
      contentType: MediaType.parse(mimeType),
      filename: fileName,
    );

    final request = http.MultipartRequest('POST', uri);
    request.files.add(multipartFile);

    final response = await request.send();
    logger.t(
        '[UploadFileEndpoint.sendRequest] Response status: ${response.statusCode}, reason: ${response.reasonPhrase}');
    return http.Response.fromStream(response);
  }

  @override
  Map<String, String> get headers => {};

  @override
  Uri get uri => Uri.parse(uploadUrl);
}

class FileInfoEndpoint extends WixRawRequestEndpoint<FileItem?> {
  FileInfoEndpoint({
    required super.accessToken,
    required String fileUrl,
  }) : super(
            path: 'velo/v1/http/invoke/file_info',
            methodType: 'GET',
            queryParams: {'fileUrl': fileUrl},
            responseBodyFormatter: ResponseBodyFormatters.toFileItem);
}

class FolderInfoEndpoint extends WixRawRequestEndpoint<FolderItem?> {
  FolderInfoEndpoint({
    required super.accessToken,
    required String folderId,
  }) : super(
            path: 'velo/v1/http/invoke/folder_info',
            methodType: 'GET',
            queryParams: {'folderId': folderId},
            responseBodyFormatter: ResponseBodyFormatters.toFolderItem);
}

class ListFilesEndpoint extends WixRawRequestEndpoint<List<FileItem>> {
  ListFilesEndpoint({
    required super.accessToken,
    String? parentFolderId,
    bool? includeSubfolders = false,
  }) : super(
          path: 'velo/v1/http/invoke/list_files',
          methodType: 'POST',
          body: {
            'parentFolderId': parentFolderId,
            'includeSubfolders': includeSubfolders,
          },
          responseBodyFormatter: ResponseBodyFormatters.toFileItems,
        );
}

class ResponseBodyFormatters {
  static Token? toAnonymousToken(String bodyStr) =>
      responseBodyToToken(grantType: GrantType.anonymous, bodyStr: bodyStr);

  static Token? toMemberToken(String bodyStr) =>
      responseBodyToToken(grantType: GrantType.member, bodyStr: bodyStr);

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

  static List<FileItem> toFileItems(String bodyStr) {
    final List<Map<String, dynamic>> files =
        (jsonDecode(bodyStr)['files'] as List).cast<Map<String, dynamic>>();
    return files
        .map<FileItem>(
          (dataItem) => FileItem.fromFields(
            {
              'id': dataItem['fileUrl'],
              'name': dataItem['name'] ?? 'no name',
              ...dataItem,
            },
          ),
        )
        .toList();
  }

  static Map<String, List<Item>> toItemsLists(String bodyStr) {
    final lists = <String, List<Item>>{};

    for (final MapEntry entry in jsonDecode(bodyStr).entries) {
      // we are changing the key to the lists from the collection id (snake_case) to the item type (camelCase)
      final String itemType = Metadata().getByCollectionId(entry.key).name;
      lists[itemType] = (entry.value as List)
          .map((dataItem) => dataItemToItem<Item>(dataItem as Map<String, dynamic>))
          .toList();
    }

    return lists;
  }

  static FileItem? toFileItem(String bodyStr) {
    if (bodyStr.isEmpty) {
      return null;
    }

    final fileInfo = jsonDecode(bodyStr)['file'];
    return FileItem.fromFields({
      'id': fileInfo['fileUrl'],
      'name': fileInfo['fileName'],
      'parentFolderId': fileInfo['parentFolderId'],
      'url': fileInfo['url'],
      'hash': fileInfo['hash'],
      'height': fileInfo['height'],
      'width': fileInfo['width'],
      'iconUrl': fileInfo['iconUrl'],
      'isPrivate': fileInfo['isPrivate'],
      'labels': fileInfo['labels'],
      'mediaType': fileInfo['mediaType'],
      'mimeType': fileInfo['mimeType'],
      'opStatus': fileInfo['opStatus'],
      'originalFileName': fileInfo['originalFileName'],
      'sizeInBytes': fileInfo['sizeInBytes'],
      'sourceURL': fileInfo['sourceURL'],
      'createdDate': DateTime.parse(fileInfo['_createdDate']),
      'updatedDate': DateTime.parse(fileInfo['_updatedDate']),
    });
  }

  static FolderItem? toFolderItem(String bodyStr) {
    if (bodyStr.isEmpty) {
      return null;
    }

    final folder = jsonDecode(bodyStr)['folder'];
    return FolderItem({
      'id': folder['id'],
      'name': folder['folderName'],
      'parentFolderId': folder['parentFolderId'],
    });
  }

  // static String toSessionToken(String bodyStr) {
  //   final Map<String, dynamic> responseBody = jsonDecode(bodyStr);
  //   return responseBody['sessionToken'] as String;
  // }

  static Token? responseBodyToToken({
    required GrantType grantType,
    Map<String, dynamic>? body,
    String? bodyStr,
  }) {
    assert(
      body != null || bodyStr != null,
      '[WixRestApi._responseBodyToToken] Either body or bodyStr must be provided',
    );

    if (bodyStr != null) {
      if (bodyStr.isEmpty) {
        logger.w('[WixRestApi._responseBodyToToken] Empty bodyStr');
        return null;
      }

      logger.t('[WixRestApi._responseBodyToToken] bodyStr: $bodyStr');
      body = jsonDecode(bodyStr);
    }

    if (body!['error'] != null) {
      logger.e('[WixRestApi._responseBodyToToken] Error: bodyStr: $bodyStr');
      return null;
    }

    return Token(
      grantType: grantType,
      accessToken: body['access_token'] as String,
      refreshToken: body['refresh_token'] as String,
      expiresAt: DateTime.now().add(Duration(seconds: body['expires_in'] as int)),
    );
  }
}
