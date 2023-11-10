import 'package:flutter/material.dart';
import '../../presentation/widgets/appbars/custom_appbar.dart';
import '../../config/auth/auth.dart';

class CalendarScreen extends StatelessWidget with CustomAppBar {
  const CalendarScreen({Key? key}) : super(key: key);

  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithMenuButton(title: 'Calendario'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Calendario'),
            TextButton(
              onPressed: signOut, 
              child: const Text('Cerrar Sesión')
            ),
          ],
        ),
      ),
    );
  }
}