import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/item.dart';
import '../../providers/event_provider.dart';
import '../../resources/labels.dart';

class EventMessenger extends ConsumerWidget {
  final Widget child;
  const EventMessenger({required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<(String, Item)?>(eventProvider, (prev, next) {
      if (next != null) {
        final message = NotificationMessages.itemEvent(next.$1, next.$2);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
        ref.read(eventProvider.notifier).clear();
      }
    });

    return child;
  }
}
