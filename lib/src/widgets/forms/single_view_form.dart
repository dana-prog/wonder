import 'package:flutter/material.dart';

class SingleViewScaffold extends StatelessWidget {
  final Widget Function(BuildContext context) viewBuilder;
  final String? title;

  const SingleViewScaffold({
    required this.viewBuilder,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title != null ? Text(title!) : null,
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: viewBuilder(context),
      ),
    );
  }
}
