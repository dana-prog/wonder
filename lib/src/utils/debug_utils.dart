import 'package:flutter/material.dart';

import '../logger.dart';

void showNavigationDialog(BuildContext context) async {
  final controller = TextEditingController();

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Navigate to Route'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: 'Type route name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(null),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(controller.text),
            child: Text('Go'),
          ),
        ],
      );
    },
  );
}

typedef AsyncFunc<T> = Future<T> Function();

AsyncFunc<T> wrapWithErrorLogging<T>({required AsyncFunc<T> function, String? errorMessage}) {
  return () async {
    try {
      return await function();
    } catch (e, stackTrace) {
      logger.e('[wrapWithErrorLogging] Error: $errorMessage', error: e, stackTrace: stackTrace);
      rethrow;
    }
  };
}
