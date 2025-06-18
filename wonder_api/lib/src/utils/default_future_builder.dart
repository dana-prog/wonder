import 'package:flutter/material.dart';

import '../logger.dart';

typedef DataBuilder<T> = Widget Function(BuildContext context, T data);

Widget defaultDataBuilder(BuildContext context, dynamic data) {
  return data != null ? Text(data.toString()) : Text('null', style: TextStyle(color: Colors.grey));
}

class DefaultFutureBuilder<T> extends StatelessWidget {
  final Future<T> future;
  final DataBuilder<T>? builder;

  const DefaultFutureBuilder({super.key, required this.future, this.builder});

  @override
  Widget build(BuildContext context) {
    logger.d('[DefaultFutureBuilder.build]');

    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.red));
        }

        if (snapshot.hasData == false || builder == null) {
          return defaultDataBuilder(context, snapshot.data);
        }

        return builder!(context, snapshot.requireData);
      },
    );
  }
}
