import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/widgets/appbars/custom_appbar.dart';
import '../../presentation/widgets/drawers/custom_drawer.dart';

import '../../static/static.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({Key? key}) : super(key: key);

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> with CustomAppBar, CustomDrawer {
  List<Map<String,dynamic>> recipesList = recipes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithMenuButton(title: 'Recetas'),
      drawer: drawerSimple(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: recipesList.length,
                itemBuilder: (context, index) {
                  final Map<String, dynamic> recipe = recipesList[index];
                  return ListTile(
                    title: Text(recipe['name']),
                    subtitle: Text(recipe['description']),
                    onTap: () => context.push('/recipes/${recipe['id']}'),
                  );
                },
              ),
            ),
            ElevatedButton(
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
                context.push('/recipes/$newId');
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
