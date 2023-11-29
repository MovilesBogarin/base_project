// ignore_for_file: null_check_always_fails

import 'package:base_project/config/helpers/dateFormater.dart';
import 'package:base_project/domain/dtos/recipe/recipe_dto.dart';
import 'package:base_project/presentation/providers/recipe/recipes_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:base_project/presentation/calendar/calendar_presenter.dart';
import 'package:base_project/presentation/widgets/inputs/Custom_Button.dart';
import 'package:base_project/static/static.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/widgets/appbars/custom_appbar.dart';
import '../../presentation/widgets/drawers/custom_drawer.dart';
import '../../../config/menu/menu_items.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});
  @override
  CalendarState createState() => CalendarState();
}

// ignore: must_be_immutable, subtype_of_sealed_class
class CalendarState extends ConsumerState<CalendarScreen>
    with CustomAppBar, CustomDrawer {
  List<Recipe> recipesList = [];
  List<Recipe> filterRecipes = [];

  List<Recipe> resultFilterRecipes(String query) {
    List<Recipe> items = [];

    if (query.isNotEmpty) {
      items = recipesList
          .where((element) =>
              element.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    return items;
  }

  @override
  void initState() {
    super.initState();
    recipesList =
        ref.read(recipesProvider.notifier).getRecipes() as List<Recipe>;
  }

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

  List recipesSeleted = [];

  String currentRecipe = 'Escoge una de tus recetas :)';

  String? recipeController;
  final ScrollController _scrollControler = ScrollController();
  late final MenuItem menuItem;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWithMenuButton(title: 'Calendario'),
        drawer: drawerSimple(context),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
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
                ),
                const SizedBox(height: 40),
                DropdownSearch(
                  mode: Mode.MENU,
                  showSearchBox: true,
                  isFilteredOnline: true,
                  dropDownButton:
                      Icon(Icons.arrow_drop_down, color: Colors.black),
                  dropdownSearchDecoration:
                      const InputDecoration(hintText: 'search recipes'),
                  showClearButton: false,
                  onFind: (value) async {
                    setState(() {});
                    return resultFilterRecipes(value.toString() ?? '');
                  },
                  onChanged: (value) {
                    setState(() {
                      filterRecipes = [value ?? null!];
                    });
                  },
                  dropdownBuilder: _customDropDownPrograms,
                  popupItemBuilder: _customPopupItemBuilder,
                  clearButtonBuilder: (_) => Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.clear, color: Colors.black),
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: filterRecipes.length,
                        itemBuilder: (context, index) {
                          return Container(
                              height: 50,
                              width: 100,
                              child: Row(children: [
                                if (filterRecipes[index].toString().isNotEmpty)
                                  Text(
                                    filterRecipes[index].name,
                                    style: TextStyle(),
                                  ),
                                const SizedBox(child: Text('hoo')),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(filterRecipes[index].name),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(filterRecipes[index].description),
                                  ],
                                ))
                              ]));
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
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Widget _customPopupItemBuilder(
      Builder context, Recipe item, bool isSelected) {
    return Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          decoration: isSelected
              ? null
              : BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context as BuildContext).highlightColor),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
          child: ListTile(
            title: Text(item.name),
          ),
        ) ??
        Container();
  }

  Widget _customDropDownPrograms(BuildContext context, Recipe? item) {
    return Container(
        // ignore: unnecessary_null_comparison
        child: (item! == null)
            ? ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text('saarch recipe'),
              )
            : ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text(item.name),
              ));
  }
}
