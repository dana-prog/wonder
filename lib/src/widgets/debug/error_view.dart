import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final Object error;
  final StackTrace? stack;

  const ErrorView(this.error, this.stack, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: SelectableText(
              '$error\n\n$stack',
              style: const TextStyle(fontFamily: 'monospace'),
            ),
          ),
        ),
      ),
    );
  }
}
