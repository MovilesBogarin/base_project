import 'package:base_project/presentation/widgets/inputs/Custom_Button.dart';
import 'package:base_project/static/static.dart';
import 'package:flutter/material.dart';
import '../../presentation/widgets/appbars/custom_appbar.dart';
import '../../presentation/widgets/drawers/custom_drawer.dart';

class CalenderRecipe extends StatefulWidget {
  final String? date1;
  final String? date2;
  const CalenderRecipe({super.key, this.date1, this.date2});

  @override
  State<CalenderRecipe> createState() => _CalendarRecipesScreenState();
}

class _CalendarRecipesScreenState extends State<CalenderRecipe>
    with CustomAppBar {
  List<Map<String, dynamic>> recipesList = recipes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithMenuButton(title: 'Calendario y recetas'),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                    '${widget.date1} ${widget.date2 != null ? 'to ${widget.date2!}' : ''}',
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: Colors.red)),
                const SizedBox(height: 30),
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
                    children: <Widget>[
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: recipesList.length,
                          itemBuilder: (context, index) {
                            final Map<String, dynamic> recipe =
                                recipesList[index];
                            return Text(recipe['description']);
                          })
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
/*
                        final newId = recipesList.length + 1;
                        recipesList.add({
                          'id': newId,
                          'name': 'Receta $newId',
                          'description': 'Descripción de la receta $newId',
                        });
                        setState(() {
                          recipesList = recipesList;
                        });
                        {}





 */

/*
            Expanded(
              child: ListView.builder(
                itemCount: recipesList.length,
                itemBuilder: (context, index) {
                  final Map<String, dynamic> recipe = recipesList[index];
                  return Expanded(
                      child: Row(children: [
                    Text(recipe['name']),
                    const SizedBox(width: 250),
                    Custom_Button(
                      txt: '+',
                      onPressed: () {
                        final newId = recipesList.length + 1;
                        recipesList.add({
                          'id': newId,
                          'name': 'Receta $newId',
                          'description': 'Descripción de la receta $newId',
                        });
                        setState(() {
                          recipesList = recipesList;
                        });
                        {}
                      },
                    )
                  ]));
                },
              ),
            ),
            



 */