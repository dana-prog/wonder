import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../client/client.dart';
import '../client/wix_client.dart';

final clientProvider = Provider<Client>((ref) {
  return client;
});

final client = WixClient();
