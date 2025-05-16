import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wonder/src/data/facility.dart';
import 'package:wonder/src/providers/wix_client_provider.dart';

final facilityListProvider = FutureProvider<List<Facility>>((ref) async {
  final wixClient = ref.watch(wixClientProvider);

  return await wixClient.fetchDataItems<Facility>('facilities', Facility.new);
});
