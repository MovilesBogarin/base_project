import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/widgets/appbars/custom_appbar.dart';
import '../../presentation/widgets/drawers/custom_drawer.dart';
<<<<<<< HEAD
import 'package:http/http.dart' as http;


import '../../static/static.dart';
import 'dart:async';
import 'dart:convert';

=======
import '../../presentation/recipes/recipes_presenter.dart';
import '../../domain/dtos/recipe_dto.dart';
>>>>>>> b3c96b22eaf22fd591c4d9e1d8871aca2aaf40ac

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({Key? key}) : super(key: key);

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> with CustomAppBar, CustomDrawer {
<<<<<<< HEAD

getRecipes() async{

http.Response response = await http.get(Uri.parse('http://10.0.2.2:7000/api/recipes/'));
debugPrint(response.body);
print("Aqui veremos que pasa: "+ response.body);

}

@override
initState(){
  super.initState();
  getRecipes();
}



  List<Map<String,dynamic>> recipesList = recipes;
=======
  List<Recipe> recipesList = RecipesPresenter().getRecipes();
>>>>>>> b3c96b22eaf22fd591c4d9e1d8871aca2aaf40ac
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
                  final Recipe recipe = recipesList[index];
                  return ListTile(
                    title: Text(recipe.name),
                    subtitle: Text(recipe.description),
                    onTap: () => context.push('/recipes/${recipe.id}'),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final newRecipe = RecipesPresenter().addRecipe();
                setState(() {
                  recipesList = RecipesPresenter().getRecipes();
                });
                context.push('/recipes/${newRecipe.id}');
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
