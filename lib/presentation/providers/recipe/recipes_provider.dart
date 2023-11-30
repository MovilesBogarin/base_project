import 'package:flutter/material.dart';
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
    state.asData!.value.firstWhere((element) => element.id == recipe.id).ingredients.add(newIngredient);
    state = AsyncValue.data([...state.asData!.value]);
    return newIngredient;
  }

  void updateIngredient(int recipeId, Ingredient ingredient, String name, num quantity, String unit) {
    Ingredient ingredientToUpdate = state.asData!.value.firstWhere((element) => element.id == recipeId).ingredients.firstWhere((element) => element.id == ingredient.id);
    ingredientToUpdate.name = name;
    ingredientToUpdate.quantity = quantity;
    ingredientToUpdate.unit = unit;
    state = AsyncValue.data([...state.asData!.value]);
  }

  int createRecipe() {
    Recipe newRecipe = RecipeCaster.toRecipe({
      'id': UniqueKey().hashCode,
      'name': 'Nueva receta',
      'description': 'Nueva descripción',
      'ingredients': [],
      'steps': [],
    });
    RecipeDataSource().createRecipe(newRecipe);
    state = AsyncValue.data([...state.asData!.value, newRecipe]);
    return newRecipe.id;
  }

  Future<void> updateRecipe(Recipe recipe) async {
    await RecipeDataSource().updateRecipe(recipe);
    Recipe recipeToUpdate = state.asData!.value.firstWhere((element) => element.id == recipe.id);
    recipeToUpdate.name = recipe.name;
    recipeToUpdate.description = recipe.description;
    recipeToUpdate.ingredients = recipe.ingredients;
    recipeToUpdate.steps = recipe.steps;
    state = AsyncValue.data([...state.asData!.value]);
  }

  void deleteRecipe(int id) {
    RecipeDataSource().deleteRecipe(id);
    state = AsyncValue.data([...state.asData!.value.where((element) => element.id != id)]);
  }
}
