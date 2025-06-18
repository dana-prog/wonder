import 'package:flutter/material.dart';
import 'package:wonder/src/theme/app_theme.dart';

import 'src/widgets/home.dart';

void main() {
  runApp(const WonderApiApp());
}

class WonderApiApp extends StatelessWidget {
  const WonderApiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Wonder API Playground', theme: AppTheme.light, home: const Home());
  }
}
