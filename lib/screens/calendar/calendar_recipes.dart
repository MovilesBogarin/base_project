import 'package:base_project/static/static.dart';
import 'package:flutter/material.dart';
import '../../presentation/widgets/appbars/custom_appbar.dart';

import 'package:dropdown_search/dropdown_search.dart';

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
  String? recipeController;

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
                DropdownSearch(
                    //recipes.map((e) => e['name']).toList()
                    items: recipes.map((e) => e['name']).toList(),
                    onChanged: ((value) {
                      setState(() {
                        recipeController = value.toString();
                      });
                    })),
                //Text(recipeController!),
                const SizedBox(height: 30),
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