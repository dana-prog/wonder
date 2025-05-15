import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_provider.dart';

final facilityListProvider = FutureProvider<List<dynamic>>((ref) async {
  final wixClient = ref.watch(wixClientProvider);

  return await wixClient.fetchItems('facilities');
});
