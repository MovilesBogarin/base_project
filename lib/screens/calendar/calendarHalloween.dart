import 'dart:html';

import 'package:flutter/material.dart';
import 'package:pactica/Views/Counter.dart';
import 'package:table_calendar/table_calendar.dart';

class practica extends StatefulWidget {
  const practica({super.key});
  @override
  State<practica> createState() => _practicaState();
}

class _practicaState extends State<practica> {
  //VARAIBLES Y METODOS PARA USAR TABLE CALENDAR, *PODEMOS MIGRARLO AL ARCHIVO DONDE ESTE LA CLASE DEL COMPONENTE DEL CALENDARIO*
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        //DRAWER ES PARA EL MINI-MENU LATERAL PODEMOS MIGRARLO A UNA  CARPETA "COMPONENTS" PARA AHORRAR CODIGO O DEJARLO ASI
        drawer: NavigationDrawer(
          backgroundColor: Colors.black,
          children: [
            Container(
              width: 150,
              height: 150,
              margin: const EdgeInsets.only(top: 65, bottom: 20),
              child: Image.network(
                  "https://media.tenor.com/ti0rtEuRNyEAAAAC/happy-halloween.gif"),
            ),
            const Text(
              textAlign: TextAlign.center,
              "Javier Garcia",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white70),
            ),
            Container(
                padding: const EdgeInsets.all(2),
                child: Wrap(
                  runSpacing: 2,
                  children: [
                    ListTile(
                      hoverColor: Colors.deepOrangeAccent,
                      splashColor: Color.fromARGB(255, 255, 0, 0),
                      tileColor: Colors.orange,
                      title: const Text('Home'),
                      onTap: () {},
                    ),
                    ListTile(
                      hoverColor: Colors.deepOrangeAccent,
                      splashColor: Color.fromARGB(255, 255, 0, 0),
                      tileColor: Colors.orange,
                      title: const Text('Counter'),
                      onTap: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => const Counter())),
                    ),
                    ListTile(
                      hoverColor: Colors.deepOrangeAccent,
                      splashColor: Color.fromARGB(255, 255, 0, 0),
                      tileColor: Colors.orange,
                      title: const Text('Crear recetas'),
                      onTap: () {},
                    ),
                    ListTile(
                      hoverColor: Colors.deepOrangeAccent,
                      splashColor: Color.fromARGB(255, 255, 0, 0),
                      tileColor: Colors.orange,
                      title: const Text('Sign out'),
                      onTap: () {},
                    )
                  ],
                )), //
          ],
        ),
        //APP-BAR es lo mismo que en clase pero a este le agregue una lista de widgets que mire por ahi en un foro que manda varios iconos del lado izq, ta chido
        appBar: AppBar(
          title: const Text('Decoracion Halloween para probar'),
          centerTitle: true,
          //Aqui la listita para agregar los iconos y el avatar :3, lo interesante va hacer el CRUD para traer fotografias y datos para agregarlos a los metodos a ver si no queda muy aparatoso
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {},
            ),
            const CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://media.tenor.com/2_Vs6_AB2BsAAAAC/esqueleto-bailando.gif"),
            ),
          ],
          backgroundColor: Colors.orangeAccent,
        ),
        //Cuerpo aqui podemos mandar al calendario a la carpeta 'components' y de ahi llamarlo pq si esta medio groso el hdp
        //Aqui es:
        // Dentro de un Safe Area Ira un Padding * Para poder hacer mas chico el calendario*
        // Dentro de ese Padding ira un Column para poder usar children y hacer una listita de hijos (aunque solo usaremos 1, igual hay que vere como mejorar la estructura)
        // Al container le damos la forma en donde estara el calendario en este caso le dimos curvatura a las esquinas y un color gris fuertesito
        // Dentro del child del Container esta el TaboleCalendar
        // TONS ES SAFEAREA -> PADDING -> COLUMN -> CONTAINER -> TABLE CALENDAR
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Column(children: [
              Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 97, 97, 97),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: TableCalendar(
                  //Sistema de idioma del calendiario no es tan necesario pero el US es el mas universal
                  locale: "en_US",
                  //Altura del espacio de cada fila del calendario
                  rowHeight: 40,
                  //Aqui podemos decorar el encabezado
                  headerStyle: const HeaderStyle(
                      decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          //Aqui hay que curviar el encabezado pq si no lo deja rectangular
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          )),
                      formatButtonVisible: false,
                      titleCentered: true),

                  availableGestures: AvailableGestures.all,
                  rangeSelectionMode: RangeSelectionMode.toggledOn,
                  // selectedDayPredicate: (day) => isSameDay(day, today),
                  focusedDay: today,
                  firstDay: DateTime.utc(2023, 01, 01),
                  lastDay: DateTime.utc(2023, 12, 31),
                  //onDaySelected: _onDaySelected,
                  rangeStartDay: _RangeStart,
                  rangeEndDay: _RangeFinish,
                  onRangeSelected: _onDaysSelected,
                  //Aqui decoramos todo lo debajo del encabezado le medio batalle para entender que el background es transparante, nmms pense que tendra un parametro que dijiera backgroundColor o alfo asi pero nel
                  //tiene mas formas de decoracion
                  calendarStyle: const CalendarStyle(
                      todayDecoration: BoxDecoration(
                          color: Colors.deepPurple, shape: BoxShape.circle),
                      defaultDecoration: BoxDecoration(
                          color: Colors.orange, shape: BoxShape.circle),
                      outsideDecoration: BoxDecoration(
                          color: Color.fromARGB(255, 85, 0, 231),
                          shape: BoxShape.circle),
                      holidayDecoration: BoxDecoration(
                          color: Colors.orange, shape: BoxShape.circle),
                      weekendDecoration: BoxDecoration(
                          color: Colors.orange, shape: BoxShape.circle),
                      selectedDecoration: BoxDecoration(
                          color: Color.fromARGB(247, 247, 95, 28),
                          shape: BoxShape.circle),
                      rangeStartDecoration: BoxDecoration(
                          color: Color.fromARGB(247, 247, 95, 28),
                          shape: BoxShape.circle),
                      rangeEndDecoration: BoxDecoration(
                          color: Color.fromARGB(247, 247, 95, 28),
                          shape: BoxShape.circle),
                      rangeHighlightColor: Color.fromARGB(159, 159, 24, 8)),
                ),
              ),
            ]),
          ),
        ));
  }
}