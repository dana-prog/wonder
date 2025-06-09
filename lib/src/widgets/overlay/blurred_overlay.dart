import 'dart:ui';

import 'package:flutter/material.dart';

typedef CloseCallback = void Function(BuildContext context);

class BlurredOverlay extends StatelessWidget {
  final Widget child;
  final CloseCallback? close;
  const BlurredOverlay({required this.child, this.close, super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Material(
      color: Colors.transparent, // keeps main view visible
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          GestureDetector(
            onTap: () => _close(context),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              // TODO: [THEME] check if we need to move this hard coded value
              child: Container(color: const Color.fromRGBO(0, 0, 0, 0.5)),
            ),
          ),
          Center(
            child: Stack(children: [
              Container(
                padding: const EdgeInsets.all(24),
                // TODO: [THEME]
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                width: screenWidth * 0.8,
                child: child,
              ),
              Positioned(
                top: 10,
                right: 5,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => _close(context),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  void _close(BuildContext context) {
    if (close != null) {
      close!(context);
    } else {
      Navigator.of(context).pop();
    }
  }
}
