import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../client/client.dart';

final clientProvider =
    Provider<Client>((ref) => throw Exception('clientProvider state was not set'));
