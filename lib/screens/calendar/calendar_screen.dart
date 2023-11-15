import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../presentation/widgets/appbars/custom_appbar.dart';
import '../../presentation/widgets/drawers/custom_drawer.dart';
import '../../config/auth/auth.dart';

class CalendarState extends StatefulWidget {
  const CalendarState({super.key});
  @override
  State<CalendarState> createState() => CalendarScreen();
}
class CalendarScreen extends State<CalendarState> with CustomAppBar, CustomDrawer {
  //CalendarScreen({Key? key}) : super(key: key);
  final String? email = Auth().currentUser?.email;

    DateTime today = DateTime.now();
  DateTime? _selecteDay;
  DateTime? _RangeStart;
  DateTime? _RangeFinish;
  //  METODO PARA SELECCIONAR UN SOLO DIA *NO LO VEO NECESARIO comente las lineas donde se usaba xd*
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  //METODO PARA SELECCIONAR UN RANGO DE FECHAS *ESTE SI ESTA CHIDO
  void _onDaysSelected(DateTime? start, DateTime? finish, DateTime focusedDay) {
    setState(() {
      _selecteDay = null;
      today = focusedDay;
      _RangeStart = start;
      _RangeFinish = finish;
    });
  }

  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: appBarWithMenuButton(title: 'Calendario'),
      drawer: drawerSimple(),
      body: Padding( padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: Container(
        decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text('Bienvenido, $email', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            TableCalendar(
              locale: "en_US",
              rowHeight: 40,
              headerStyle: const HeaderStyle(
                          decoration: BoxDecoration(
                          color: Color.fromARGB(255, 26, 57, 91),
                          //Aqui hay que curviar el encabezado pq si no lo deja rectangular
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          )),
                      formatButtonVisible: false,
                      titleCentered: true),
              availableGestures: AvailableGestures.all,
              rangeSelectionMode: RangeSelectionMode.toggledOn, 
              rangeStartDay: _RangeStart,
              rangeEndDay: _RangeFinish,
              onRangeSelected: _onDaysSelected,
              firstDay: DateTime.utc(2023, 1, 1),
              lastDay: DateTime.utc(2023, 12, 31),
              focusedDay: today,
            ),
            TextButton(
              onPressed: signOut, 
              child: const Text('Cerrar Sesión')
            ),

          ],
        ),
      ),
      
      )
    );
  }

   




  
}