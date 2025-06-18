import 'dart:async';

import 'package:wonder/src/client/wix/wix_api_service.dart';
import 'package:wonder/src/client/wix/wix_authentication.dart';

import '../../data/item.dart';
import '../../logger.dart';
import '../client.dart';
import '../token.dart';

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
  'facility': {'type': 'd9c1d2a1-17fe-4f3f-b035-dcbe4905e444'},
};

class WixClient extends Client {
  WixClient({required super.authentication});

  static Future<WixClient> create({required String authRedirectUrl, Token? token}) async {
    final authentication =
        await WixAuthentication.create(authRedirectUrl: authRedirectUrl, token: token);
    return WixClient(authentication: authentication);
  }

  @override
  Future<T> fetchItem<T extends Item>({required String itemType, required String id}) async {
    logger.t('[WixClient.fetchItem] $itemType/$id');

    await authentication.login();

    final cachedItem = getCachedItem<T>(itemType, id);
    if (cachedItem != null) {
      return cachedItem;
    }

    assert(authentication.token?.isValid == true,
        '[WixRestClient.fetchItem] calling wix rest endpoint with non valid token');

    final item = await FetchItemEndpoint<T>(
      accessToken: authentication.accessToken,
      itemType: itemType,
      id: id,
    ).call();

    notifyItemFetched(item); // updates cache
    return item;
  }

  @override
  Future<List<T>> fetchItems<T extends Item>({required String itemType}) async {
    logger.t('[WixClient.fetchItems] $itemType');

    await authentication.login();

    final items = await FetchItemsEndpoint<T>(
      accessToken: authentication.accessToken!,
      itemType: itemType,
    ).call();

    for (final item in items) {
      notifyItemFetched(item); // updates the cache
    }

    return items;
  }

  @override
  Future<T> createItem<T extends Item>(Map<String, dynamic> fields) async {
    logger.d('[WixClient.addItem] $fields');

    await authentication.login();

    final item = await CreateItemEndpoint<T>(
      accessToken: authentication.accessToken,
      fields: fields,
    ).call();

    notifyItemCreated(item); // updates cache
    return cache[item.id!];
  }

  @override
  Future<T> updateItem<T extends Item>(T newItem) async {
    final item = await UpdateItemEndpoint<T>(
      accessToken: authentication.accessToken,
      item: newItem,
    ).call();

    notifyItemUpdated(item); // updates cache
    return cache[item.id!];
  }

  @override
  Future<T> deleteItem<T extends Item>(T item) async {
    await authentication.login();

    await DeleteItemEndpoint<T>(
      accessToken: authentication.accessToken,
      itemType: item.itemType,
      id: item.id!,
    ).call();

    notifyItemDeleted(item); // updates cache
    return item;
  }

  Future<Map<String, List<Item>>> fetchStaticLists() async {
    await authentication.login();
    return await FetchStaticListsEndpoint(accessToken: authentication.accessToken).call();
  }

  Future<String> generateUploadUrl({required String fileName, String? folderPath}) async {
    await authentication.login();
    return await GenerateUploadUrlEndpoint(
      accessToken: authentication.accessToken,
      fileName: fileName,
      folderPath: folderPath,
    ).call();
  }
}
