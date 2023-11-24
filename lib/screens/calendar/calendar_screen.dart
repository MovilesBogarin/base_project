import 'package:base_project/config/helpers/dateFormater.dart';
import 'package:base_project/presentation/calendar/calendar_presenter.dart';
import 'package:base_project/presentation/widgets/inputs/Custom_Button.dart';
import 'package:base_project/static/static.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

  String formatDate(DateTime? date) {
    return '${date?.add(const Duration(days: 1)).fullDate()}';
  }

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

  List<Map<String, dynamic>> recipesList = recipes;
  List recipesSeleted = [];

  String currentRecipe = 'Escoge una de tus recetas :)';

  String? recipeController;
  final ScrollController _scrollControler = ScrollController();
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
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text('Bienvenido, $email',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                tableCalendarCustom(
                    RangeStart, RangeFinish, _onDaysSelected, today),
                const SizedBox(height: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                        '${formatDate(RangeStart)} ${RangeFinish != null ? 'to ' + formatDate(RangeFinish) : ''}',
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: Colors.black)),
                    const SizedBox(height: 10),
                    Custom_Button(
                      txt: 'Agregar recetas',
                      onPressed: () {
                        var date1 = "${formatDate(RangeFinish)}";
                        var date2 = "${formatDate(RangeStart)}";
                        var recipeParam = recipesSeleted.toString();
                        context.push(
                            '/recipes/clendar/$date1/$date2/$recipeParam');
                      },
                    ),
                    Text(recipesSeleted.toString())
                  ],
                ),
                const SizedBox(height: 40),
                DropdownSearch(
                    //recipes.map((e) => e['name']).toList()
                    items: recipes.map((e) => e['name']).toList(),
                    onChanged: ((value) {
                      setState(() {
                        recipeController = value.toString();
                        recipesSeleted.add(value);
                      });
                    })),
                Column(
                  children: <Widget>[
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: recipesSeleted.length,
                        itemBuilder: (context, index) {
                          return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  recipesSeleted[index],
                                  style: TextStyle(),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        recipesSeleted
                                            .remove(recipesSeleted[index]);
                                      });
                                    },
                                    icon: const Icon(Icons.delete))
                              ]);
                        }),
                    TextButton(
                        onPressed: signOut, child: const Text('Cerrar Sesión')),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
