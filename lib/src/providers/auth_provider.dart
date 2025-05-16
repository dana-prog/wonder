import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wonder/src/providers/wix_client_provider.dart';
import 'package:wonder/src/wix/sdk/wix_authentication.dart';

final authProvider = Provider<WixAuthentication>((ref) {
  final client = ref.watch(wixClientProvider);
  return client.authentication;
});
