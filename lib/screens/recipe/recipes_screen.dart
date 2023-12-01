import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/dtos/recipe/recipe_dto.dart';
import '../../presentation/providers/recipe/recipes_provider.dart';
import '../../presentation/widgets/appbars/custom_appbar.dart';
import '../../presentation/widgets/drawers/custom_drawer.dart';
import '../../presentation/widgets/loading/loading.dart';

class RecipesScreen extends ConsumerStatefulWidget {
  const RecipesScreen({super.key});

  @override
  RecipesScreenState createState() => RecipesScreenState();
}

class RecipesScreenState extends ConsumerState<RecipesScreen>
    with CustomAppBar, CustomDrawer, Loading {
  @override
  void initState() {
    super.initState();
    ref.read(recipesProvider.notifier).getRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithMenuButton(title: 'Recetas'),
      drawer: drawerSimple(context),
      body: Consumer(builder: (context, ref, _) {
        final provider = ref.watch(recipesProvider);
        return provider.when(
          loading: () => loading,
          error: (error, stack) => const Center(child: Text('Error')),
          data: (recipesList) => SafeArea(
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
                        onTap: () async {
                          await context.push('/recipes/${recipe.id}');
                          // TODO: Refactorize
                          setState(() {});
                        },
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    String newId =
                        ref.read(recipesProvider.notifier).createRecipe();
                    await context.push('/recipes/$newId');
                    // TODO: Refactorize
                    setState(() {});
                  },
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
