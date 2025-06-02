import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../client/client.dart';
import '../client/wix_client.dart';

final clientProvider = Provider<Client>((ref) {
  return _client;
});

// final _client = LocalDevClient();
final _client = WixClient();
