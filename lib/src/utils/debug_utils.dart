import 'package:flutter/material.dart';

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
