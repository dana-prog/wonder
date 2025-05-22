import 'package:flutter/material.dart';

import '../../logger.dart';

class DebugView extends StatefulWidget {
  const DebugView({super.key});

  @override
  State<StatefulWidget> createState() => _DebugViewState();
}

class _DebugViewState extends State<DebugView> {
  String _input = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              onChanged: (val) => setState(() => _input = val),
            ),
            const SizedBox(width: 8),
            getDebugWidget(),
          ],
        ),
      ),
    );
  }

  Widget getDebugWidget() {
    logger.d('[DebugViewDebugView.getDebugWidget] widgetName: $_input');

    if (_input.isEmpty) {
      return const SizedBox();
    }

    switch (_input.toLowerCase()) {}

    return Center(
      child: Text('No debug widget found for: $_input'),
    );
  }
}
