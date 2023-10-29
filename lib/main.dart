import 'package:flutter/material.dart';
import './config/theme/app_theme.dart';
import 'presentation/screens/login_page.dart';
// import 'package:base_project/presentation/screens/simple_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Structured',
      home: const LoginPage(),
      theme: AppTheme().theme(),
    );
  }
}
