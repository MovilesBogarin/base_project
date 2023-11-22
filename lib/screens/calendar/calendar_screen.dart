import 'package:base_project/config/helpers/dateFormater.dart';
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
                const SizedBox(height: 20),
                Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 229, 195, 166),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                  child: Column(
                    children: [
                      Text(
                          // ignore: unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings
                          '${RangeStart != null ? RangeStart!.add(const Duration(days: 1)).fullDate() : ""}  ${RangeFinish != null ? 'to ' + RangeFinish!.add(const Duration(days: 1)).fullDate() : ""}',
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              color: Colors.white)),
                      const SizedBox(height: 30),
                      Container(
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 54, 60, 102),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            )),
                        child: TextButton(
                            style: TextButton.styleFrom(
                                textStyle:
                                    const TextStyle(color: Colors.white)),
                            onPressed: () {
                              context.push('/calendar/recipes');
                            },
                            child: const Text(
                              'Agregar a estos dias :) ',
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ],
                  ),
                ),
                TextButton(
                    onPressed: signOut, child: const Text('Cerrar Sesión')),
              ],
            ),
          ),
        ));
  }
}
// ${RangeStart != null ? RangeStart!.fullDate() : ""}