import 'package:base_project/domain/dtos/schedule_recipe/schedule_recipe_dto.dart';
import 'package:base_project/infrastructure/casters/schedule_recipe_caster/schedule_recipe_caster.dart';
import 'package:base_project/infrastructure/dataSources/schedule_recipe_data_source.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part  'schedule_recipes_provider.g.dart';



@riverpod
class ScheduleRecipes extends _$ScheduleRecipe {
  ScheduleRecipes() : super();

  @override
  Future<List<ScheduleRecipe>> build() async => await getScheduleRecipes();

  Future<List<ScheduleRecipe>> getScheduleRecipes() async {
    return await ScheduleRecipeDataSource().getScheduleRecipes();
  }

/*
  int createScheduleRecipe() {
    ScheduleRecipe newSchedule = ScheduleRecipeCaster.toSchedule({
      'id_schedule': UniqueKey().hashCode,
      'id_recipe': 0,
      'quantity': 0,
      'date': [],
      
    });
*//*
    ScheduleRecipeDataSource().createScheduleRecipe(newSchedule);
    state = AsyncValue.data([...state.asData!.value, newSchedule]);
    return newSchedule.id;
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
  */
}
