import 'package:base_project/config/helpers/dateFormater.dart';

import 'package:base_project/domain/dtos/recipe/recipe_dto.dart';
import 'package:base_project/domain/dtos/schedule_recipe/schedule_recipe_dto.dart';
import 'package:base_project/presentation/calendar/calendar_presenter.dart';
import 'package:base_project/presentation/providers/recipe/recipes_provider.dart';
import 'package:base_project/presentation/providers/schedule_recipe/schedule_recipes_provider.dart';
import 'package:base_project/presentation/widgets/inputs/Custom_Button.dart';
import 'package:base_project/presentation/widgets/loading/loading.dart';

import 'package:dropdown_search/dropdown_search.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../presentation/widgets/appbars/custom_appbar.dart';
import '../../presentation/widgets/drawers/custom_drawer.dart';
import '../../../config/menu/menu_items.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});
  @override
  CalendarState createState() => CalendarState();
}

class CalendarState extends ConsumerState<CalendarScreen>
    with CustomAppBar, CustomDrawer, Loading {
  DateTime today = DateTime.now();
  DateTime? _selecteDay;
  DateTime? RangeStart;
  DateTime? RangeFinish;
  String? daySelect;
  late ScheduleRecipe currentSchedule;
  int id = 0;

  @override
  void initState() {
    super.initState();
    ref.read(recipesProvider.notifier).getRecipes();
    ref.read(scheduleRecipesProvider.notifier).getScheduleRecipes();
  }

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

  createScheduleRecipe() => ref
      .read(scheduleRecipesProvider.notifier)
      .createSchedule(currentSchedule);

  updateScheduleRecipe() => ref
      .read(scheduleRecipesProvider.notifier)
      .updateScheduleRecipe(currentSchedule);

  deleteScheduleRecipe() =>
      ref.read(scheduleRecipesProvider.notifier).deleteScheduleRecipe(id);

  // List<Map<String, dynamic>> recipesList = recipes;
  List<Recipe> recipesSeleted = [];
  List<ScheduleRecipe> scheduleListSelected = [];

  String currentRecipe = 'Escoge una de tus recetas :)';

  String? recipeController;
  int quantity = 0;
  final ScrollController _scrollControler = ScrollController();

  late final MenuItem menuItem;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWithMenuButton(title: 'Calendario'),
        drawer: drawerSimple(context),
        body: Consumer(builder: (context, ref, _) {
          final provider = ref.watch(recipesProvider);
          final providerS = ref.watch(scheduleRecipesProvider);

          return provider.when(
              loading: () => loading,
              error: (error, stack) => const Center(child: Text('Error')),
              data: (recipesList) {
                return providerS.when(
                  error: (error, stack) => const Center(child: Text('Error')),
                  loading: () => loading,
                  data: (scheduleList) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 30),
                    child: Container(
                      decoration: bodyCustom(),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          tableCalendarCustom(
                              RangeStart, RangeFinish, _onDaysSelected, today),
                          const SizedBox(height: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Custom_Button(
                                txt: 'Generar reporte',
                                onPressed: () {
                                  var date1 = "${formatDate(RangeFinish)}";
                                  var date2 = "${formatDate(RangeStart)}";
                                  var recipeParam = recipesSeleted.toString();
                                  context.push(
                                      '/recipes/clendar/$date1/$date2/$recipeParam');
                                },
                              ),
                              const SizedBox(height: 10),
                            ],
                          ), //******* */
                          const SizedBox(height: 40),
                          //recipesList.map((e) => e.name).toList()
                          if (RangeFinish == null)
                            DropdownSearch(
                                items: recipesList,
                                itemAsString: (Recipe item) => item.name,
                                onChanged: ((value) {
                                  setState(() {
                                    recipeController = value.toString();

                                    daySelect = DateFormat('yyyy-MM-dd')
                                        .format(RangeStart ?? DateTime.now());

                                    currentSchedule = ScheduleRecipe(
                                        id_schedule: UniqueKey().hashCode,
                                        id_recipe: value!.id,
                                        quantity: 1,
                                        date: daySelect!);

                                    createScheduleRecipe();
                                  });
                                })),

                          Column(
                            children: <Widget>[
                              const SizedBox(height: 40),
                              if (RangeFinish == null)
                                Text(
                                    'Recetas para ${formatDate((RangeStart ?? DateTime.now()))}'),
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: scheduleIsInsSelected(scheduleList,
                                          RangeStart ?? DateTime.now())
                                      .length,
                                  itemBuilder: (context, index) {
                                    scheduleListSelected =
                                        scheduleIsInsSelected(scheduleList,
                                            RangeStart ?? DateTime.now());
                                    return Container(
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${schedueRecipeName(scheduleListSelected[index].id_recipe, recipesList)} ',
                                              style: TextStyle(),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    currentSchedule =
                                                        scheduleListSelected[
                                                            index];
                                                    currentSchedule.quantity =
                                                        scheduleListSelected[
                                                                    index]
                                                                .quantity +
                                                            1;
                                                    updateScheduleRecipe();
                                                  });
                                                },
                                                icon: const Icon(Icons.add)),
                                            IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    if (scheduleListSelected[
                                                                index]
                                                            .quantity >
                                                        1)
                                                      currentSchedule =
                                                          scheduleListSelected[
                                                              index];
                                                    currentSchedule.quantity =
                                                        scheduleListSelected[
                                                                    index]
                                                                .quantity -
                                                            1;

                                                    updateScheduleRecipe();
                                                  });
                                                },
                                                icon: const Icon(Icons.remove)),
                                            Text(
                                              '${scheduleListSelected[index].quantity}',
                                              style: TextStyle(),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    id = scheduleListSelected[
                                                            index]
                                                        .id_schedule;
                                                    deleteScheduleRecipe();
                                                  });
                                                },
                                                icon: const Icon(Icons.delete)),
                                          ]),
                                    );
                                  }),
                            ],
                          ),
                          const SizedBox(height: 40),

                          /*if (RangeFinish == null)
                            Custom_Button(
                              txt: 'Guardar recetas',
                              onPressed: () {},
                            ),
                          const SizedBox(height: 40),
                          Text(scheduleList.toString())*/
                          /*** */
                        ],
                      ),
                    ),
                  ),
                );
              });
        }));
  }
}

String? schedueRecipeName(int id_schedule, List<Recipe> recipes) {
  String? nombre;

  print(id_schedule);

  Recipe? recipeEncontrada = recipes.firstWhere(
    (recipe) => recipe.id == id_schedule,
    orElse: () => Recipe(
        id: 0,
        name: 'No encontrado',
        description: '',
        ingredients: [],
        steps: []),
  );

  if (recipeEncontrada.id != 0) {
    nombre = recipeEncontrada.name;
  }

  return nombre;
}

List<ScheduleRecipe> scheduleIsInsSelected(
    List<ScheduleRecipe> scheduleList, DateTime startDate) {
  List<ScheduleRecipe> selectedSchedule = [];

  String formattedStartDate = DateFormat('yyyy-MM-dd').format(startDate);

  for (ScheduleRecipe schedule in scheduleList) {
    if (schedule.date == formattedStartDate) {
      selectedSchedule.add(schedule);
    }
  }

  return selectedSchedule;
}
