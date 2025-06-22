import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/item.dart';
import '../../providers/event_provider.dart';
import '../../resources/labels.dart';

class EventMessenger extends ConsumerWidget {
  final Widget child;
  const EventMessenger({required this.child, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<(String, Item)?>(eventProvider, (prev, next) {
      if (next != null) {
        // defer UI interaction to after build
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final overlay = Overlay.of(context, rootOverlay: true);
          final messenger = ScaffoldMessenger.of(context);
          final message = NotificationMessages.itemEvent(next.$1, next.$2);

          messenger.showSnackBar(
            SnackBar(
              content: Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text(message)),
            ),
          );
          ref.read(eventProvider.notifier).clear();
        });
      }
    });

    return child;
  }
}
