import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../client/client.dart';

final clientProvider =
    Provider<Client>((ref) => throw Exception('listsValuesProvider state was not set'));
