import 'package:wonder/src/client/wix/wix_file_storage_plugin.dart';

import '../client.dart';
import '../token.dart';
import 'wix_authentication.dart';
import 'wix_items_client.dart';

class WixClient extends Client {
  WixClient._({
    required super.itemsClient,
    required super.fileStoragePlugin,
  });

  static Future<WixClient> create({
    required String authRedirectUrl,
    Token? token,
  }) async {
    final authentication = await WixAuthentication.create(
      authRedirectUrl: authRedirectUrl,
      token: token,
    );

    return WixClient._(
      itemsClient: WixItemsClient(authentication: authentication),
      fileStoragePlugin: WixFileStoragePlugin(authentication: authentication),
    );
  }
}
