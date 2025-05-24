import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wonder/src/wix/sdk/local_dev_client.dart';

import '../wix/sdk/client.dart';

final clientProvider = Provider<Client>((ref) {
  return _client;
});

final _client = LocalDevClient();
// final _client = WixClient();
