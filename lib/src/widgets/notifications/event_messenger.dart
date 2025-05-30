import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../data/item.dart';
import '../../providers/event_provider.dart';
import '../../resources/labels.dart';

class EventMessenger extends ConsumerWidget {
  final Widget child;
  const EventMessenger({required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overlay = Overlay.of(context, rootOverlay: true);
    ref.listen<(String, Item)?>(eventProvider, (prev, next) {
      if (next != null) {
        final message = NotificationMessages.itemEvent(next.$1, next.$2);
        showTopSnackBar(
          overlay,
          CustomSnackBar.success(message: message),
        );
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
        ref.read(eventProvider.notifier).clear();
      }
    });

    return child;
  }
}
