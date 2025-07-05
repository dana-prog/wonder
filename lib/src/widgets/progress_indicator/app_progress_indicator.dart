import 'package:flutter/material.dart';

class AppProgressIndicator extends StatelessWidget {
  final double? size;
  const AppProgressIndicator({this.size}) : super();

  @override
  Widget build(BuildContext context) {
    // return Center(child: const CircularProgressIndicator());
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
        ),
      ),
    );
  }
}
