import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../domain/dtos/recipe/recipe_dto.dart';
import '../../../infrastructure/dataSources/recipe_data_source.dart';
import '../../../domain/dtos/ingredient/ingredient_dto.dart';
import '../../../infrastructure/casters/ingredient/ingredient_caster.dart';

import '../../../infrastructure/casters/recipe/recipe_caster.dart';

part 'recipes_provider.g.dart';

@riverpod
class Recipes extends _$Recipes {
  Recipes() : super();

  @override
  FutureOr<List<Recipe>> build() async => await getRecipes();

  Future<List<Recipe>> getRecipes() async {
    return await RecipeDataSource().getRecipes();
  }

  Recipe getRecipe(int id) {
    final currentState = state.asData?.value ?? [];
    return currentState.firstWhere((element) => element.id == id);
  }

  Ingredient createIngredient(Recipe recipe) {
    int newId = recipe.ingredients.length + 1;
    Ingredient newIngredient = IngredientCaster.toIngredient({
      'id': newId,
      'name': '',
      'quantity': 0,
      'unit': '',
    });
    recipe.ingredients.add(newIngredient);
    return newIngredient;
  }

  int createRecipe() {
    int newId = state.asData!.value.length + 1;
    Recipe newRecipe = RecipeCaster.toRecipe({
      'id': newId,
      'name': 'Nueva receta',
      'description': 'Nueva descripción',
      'ingredients': [],
      'steps': [],
    });
    state.asData!.value.add(newRecipe);
    return newRecipe.id;
  }
}
