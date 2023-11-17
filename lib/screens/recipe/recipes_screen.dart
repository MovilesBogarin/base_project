import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/widgets/appbars/custom_appbar.dart';
import '../../presentation/widgets/drawers/custom_drawer.dart';
import '../../presentation/recipes/recipes_presenter.dart';
import '../../domain/dtos/recipe_dto.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({Key? key}) : super(key: key);

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> with CustomAppBar, CustomDrawer {
  List<Recipe> recipesList = RecipesPresenter().getRecipes();
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
