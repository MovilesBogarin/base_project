import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
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
    final today = DateTime.now();
    final pastYear = today.year - 1;
    final nextYear = today.year + 1;
    return Scaffold(
      appBar: appBarWithMenuButton(title: 'Calendario'),
      drawer: drawerSimple(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text('Bienvenido, $email',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            TableCalendar(
              firstDay: DateTime.utc(pastYear, 1, 1),
              lastDay: DateTime.utc(nextYear, 12, 31),
              focusedDay: today,
            ),
            TextButton(onPressed: signOut, child: const Text('Cerrar Sesión')),
          ],
        ),
      ),
    );
  }
}
