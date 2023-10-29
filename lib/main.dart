import 'package:flutter/material.dart';
import './config/theme/app_theme.dart';
import './presentation/router/router.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Food Structured',
      theme: AppTheme().theme(),
      routerConfig: router,
    );
  }
}
