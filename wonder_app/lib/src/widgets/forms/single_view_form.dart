import 'package:flutter/material.dart';

class SingleViewScaffold extends StatelessWidget {
  final Widget child;
  final String? title;
  final bool blurredOverlay;

  const SingleViewScaffold({
    required this.child,
    this.title,
    this.blurredOverlay = false,
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
        child: child,
      ),
    );
  }
}
