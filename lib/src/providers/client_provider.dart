import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../client/items_client.dart';

final clientProvider =
    Provider<ItemsClient>((ref) => throw Exception('clientProvider state was not set'));
