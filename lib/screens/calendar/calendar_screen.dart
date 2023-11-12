import 'package:flutter/material.dart';
import '../../presentation/widgets/appbars/custom_appbar.dart';
import '../../presentation/widgets/drawers/custom_drawer.dart';
import '../../config/auth/auth.dart';

class CalendarScreen extends StatelessWidget with CustomAppBar, CustomDrawer {
  CalendarScreen({Key? key}) : super(key: key);
  final String? email = Auth().currentUser?.email;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithMenuButton(title: 'Calendario'),
      drawer: drawerSimple(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Calendario of $email'),
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