import 'package:flutter/material.dart';

import '../widgets/platform/data_viewer.dart';

void showData({
  required BuildContext context,
  required dynamic data,
  String? title,
  String? viewType,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title ?? 'Data'),
      content: DataViewer(data: data, viewType: viewType),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Close')),
      ],
    ),
  );
}

void showMessage(BuildContext context, {required String message, String? title}) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      content: Text(message),
      icon: Icon(Icons.warning_outlined),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Close')),
      ],
    ),
  );
}
