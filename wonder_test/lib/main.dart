import 'package:flutter/material.dart';
import 'package:wonder/src/theme/app_theme.dart';

import 'src/pages/wix_authentication_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wonder Test',
      // theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      theme: AppTheme.light,
      // home: const WixAuthenticationPage(),
      home: const Root(title: 'Wonder Test Home Page'),
    );
  }
}

class Root extends StatelessWidget {
  const Root({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wonder Test')),
      body: WixApi(),
    );
  }
}
