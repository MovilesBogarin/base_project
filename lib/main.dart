import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import './config/theme/app_theme.dart';
import 'config/router/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

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
