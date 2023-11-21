import 'package:base_project/presentation/calendar/calendar_presenter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../presentation/widgets/appbars/custom_appbar.dart';
import '../../presentation/widgets/drawers/custom_drawer.dart';
import '../../config/auth/auth.dart';
import '../../../config/menu/menu_items.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});
  @override
  State<CalendarScreen> createState() => CalendarState();
}

class CalendarState extends State<CalendarScreen>
    with CustomAppBar, CustomDrawer {
  final String? email = Auth().currentUser?.email;
  DateTime today = DateTime.now();
  DateTime? _selecteDay;
  DateTime? RangeStart;
  DateTime? RangeFinish;

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  void _onDaysSelected(DateTime? start, DateTime? finish, DateTime focusedDay) {
    setState(() {
      _selecteDay = null;
      today = focusedDay;
      RangeStart = start;
      RangeFinish = finish;
    });
  }

  Future<void> signOut() async {
    await Auth().signOut();
  }

  late final MenuItem menuItem;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWithMenuButton(title: 'Calendario'),
        drawer: drawerSimple(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Container(
            decoration: bodyCustom(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text('Bienvenido, $email',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                tableCalendarCustom(
                    RangeStart, RangeFinish, _onDaysSelected, today),
                const SizedBox(height: 80),
                TextButton(
                    onPressed: () {},
                    child: const Text('Este boton hara algo :) ')),
                TextButton(
                    onPressed: signOut, child: const Text('Cerrar Sesión')),
              ],
            ),
          ),
        ));
  }
}
