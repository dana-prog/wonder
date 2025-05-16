import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../wix/sdk/wix_client.dart';

final wixClientProvider = Provider<WixClient>((ref) {
  return _wixClient;
});

final _wixClient = WixClient();
