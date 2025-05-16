import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wonder/src/data/value_item.dart';
import 'package:wonder/src/providers/wix_client_provider.dart';

final listsOfValuesProvider = FutureProvider<ListsOfValues>((
  ref,
) async {
  final wixClient = ref.watch(wixClientProvider);
  return await wixClient.listsOfValues.future;
});

final listOfValuesProvider = FutureProvider.family<List<ValueItem>, ValueItemType>((
  ref,
  listType,
) async {
  final listsOfValues = await ref.watch(listsOfValuesProvider.future);
  return listsOfValues.getList(listType);
});

final valueItemProvider = FutureProvider.family<ValueItem, String>((
  ref,
  id,
) async {
  final listsOfValues = await ref.watch(listsOfValuesProvider.future);
  return listsOfValues.getValue(id);
});
