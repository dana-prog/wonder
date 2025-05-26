import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../wix/sdk/client.dart';
import '../wix/sdk/wix_client.dart';

final clientProvider = Provider<Client>((ref) {
  return _client;
});

// final _client = LocalDevClient();
final _client = WixClient();
