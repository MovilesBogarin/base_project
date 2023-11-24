import 'package:base_project/presentation/widgets/inputs/Custom_Button.dart';
import 'package:base_project/static/noStatic.dart';

import 'package:base_project/static/static.dart';
import 'package:flutter/material.dart';
import '../../presentation/widgets/appbars/custom_appbar.dart';

import 'package:dropdown_search/dropdown_search.dart';

class CalenderRecipe extends StatefulWidget {
  final String? date1;
  final String? date2;
  final String? recipeParam;
  const CalenderRecipe({super.key, this.date1, this.date2, this.recipeParam});

  @override
  State<CalenderRecipe> createState() => _CalendarRecipesScreenState();
}

class _CalendarRecipesScreenState extends State<CalenderRecipe>
    with CustomAppBar {
  String currentRecipe = 'Escoge una de tus recetas :)';

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
                    '${widget.date2} ${widget.date1 != null ? 'to ${widget.date1!}' : ''}',
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: Colors.red)),
                const SizedBox(height: 30),
                Text('${widget.recipeParam}'),
                const SizedBox(height: 30),
              ],
            ),
          )),
    );
  }
}
