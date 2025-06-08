import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final Object? error;
  final StackTrace? stackTrace;

  const ErrorView(this.error, this.stackTrace);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            error.toString(),
            style: TextStyle(color: Colors.red.shade500),
          ),
          if (stackTrace != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                stackTrace.toString(),
                style: TextStyle(fontSize: 12, color: Colors.red.shade500),
              ),
            ),
        ],
      ),
    );
  }
}

Widget getErrorView(Object error, StackTrace stackTrace) {
  return ErrorView(
    error,
    stackTrace,
  );
}
