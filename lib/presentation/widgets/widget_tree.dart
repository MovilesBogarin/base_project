import 'package:base_project/config/auth/auth.dart';
import 'package:base_project/screens/index.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/widgets.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Test();
          } else {
            return const LoginPage();
          }
        });
  }
}
