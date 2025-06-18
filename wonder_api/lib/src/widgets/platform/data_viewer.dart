import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_json_view/flutter_json_view.dart';

import '../../logger.dart';

class DataViewer extends StatelessWidget {
  final String text;
  final String? viewType; // json, text

  DataViewer({required dynamic data, this.viewType})
    : text = data is String ? data : JsonEncoder.withIndent('  ').convert(data),
      super();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(child: contentBuilder()),
        Positioned(
          right: 0,
          top: 0,
          child: IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: text));
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Copied to clipboard')));
            },
          ),
        ),
      ],
    );
  }

  Widget contentBuilder() {
    if (viewType == null || viewType == 'json') {
      return JsonView.string(text);
    }

    if (viewType != 'text') {
      logger.w('Unsupported content type: $viewType, defaulting to text view');
    }
    return TextField(
      controller: TextEditingController(text: text.toString()),
      readOnly: true,
      maxLines: null,
      decoration: const InputDecoration(
        border: InputBorder.none,
        isCollapsed: true,
        contentPadding: EdgeInsets.zero,
      ),
      style: const TextStyle(fontFamily: 'monospace'),
    );
  }

  Widget copyToClipboardButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.copy),
      onPressed: () {
        final data = const JsonEncoder.withIndent('  ').convert(text);
        Clipboard.setData(ClipboardData(text: data));
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Copied to clipboard')));
      },
    );
  }
}
