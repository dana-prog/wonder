import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wonder/src/wix/sdk/wix_authentication.dart';

import '../wix/sdk/wix_client.dart';

final wixClientProvider = Provider<WixClient>((ref) {
  return WixClient();
});

final authProvider = Provider<WixAuthentication>((ref) {
  final client = ref.watch(wixClientProvider);
  return client.authentication;
});
