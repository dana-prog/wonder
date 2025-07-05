import 'package:flutter/material.dart' hide Chip;
import 'package:wonder/src/client/authentication.dart';
import 'package:wonder/src/client/wix/wix_file_storage_plugin.dart';
import 'package:wonder/src/client/wix/wix_items_client.dart';
import 'package:wonder/src/storage/file_storage.dart';

import 'api_calls.dart';
import 'authentication_button.dart';

const _title = 'Wonder API Playground';

class Home extends StatelessWidget {
  final WixItemsClient itemsClient;
  final WixFileStoragePlugin fileStorage;

  Home({required Authentication authentication, super.key})
    : itemsClient = WixItemsClient(authentication: authentication),
      fileStorage = WixFileStoragePlugin(authentication: authentication),
      super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      body: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ApiCalls(itemsClient: itemsClient, fileService: FileStorage(fileStorage)),
              ),
              Positioned(
                bottom: 16,
                right: 16,
                child: AuthenticationButton(authentication: itemsClient.authentication),
              ),
            ],
          );
        },
      ),
    );
  }
}
