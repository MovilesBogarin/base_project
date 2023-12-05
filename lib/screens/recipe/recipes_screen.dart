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
  bool _isEditing = false;
  @override
  void initState() {
    super.initState();
    ref.read(recipesProvider.notifier).getRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithMenuButton(
          title: 'Recetas',
          button: IconButton(
              onPressed: () => setState(() {
                    _isEditing = !_isEditing;
                  }),
              icon: Icon(_isEditing ? Icons.check : Icons.edit))),
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
                        trailing: _isEditing
                            ? IconButton(
                                icon: const Icon(Icons.delete, size: 16),
                                onPressed: () {
                                  showAlertDialog(context, () {
                                    ref
                                        .read(recipesProvider.notifier)
                                        .deleteRecipe(recipe.id);
                                  });
                                })
                            : null,
                        onTap: () {
                          context.push('/recipes/${recipe.id}');
                        },
                      );
                    },
                  ),
                ),
                if (recipesList.isEmpty)
                  const Expanded(child: Center(child: Text('No hay recetas'))),
                ElevatedButton(
                  onPressed: () {
                    int newId =
                        ref.read(recipesProvider.notifier).createRecipe();
                    context.push('/recipes/$newId');
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

showAlertDialog(BuildContext context, Function() delete) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Eliminar receta"),
        content: const Text(
            "¿Estás seguro de querer eliminar esta receta? Esta acción es irreversible."),
        actions: [
          TextButton(
            child: const Text("Cancelar"),
            onPressed: () {
              context.pop();
            },
          ),
          TextButton(
            child: const Text("Eliminar"),
            onPressed: () {
              delete();
              context.pop();
            },
          ),
        ],
      );
    },
  );
}
