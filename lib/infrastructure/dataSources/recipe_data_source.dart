import 'package:base_project/domain/dtos/schedule_recipe/schedule_recipe_dto.dart';
import 'package:base_project/infrastructure/casters/recipe/recipe_caster.dart';
import 'package:base_project/infrastructure/casters/schedule_recipe_caster/schedule_recipe_caster.dart';
import 'package:dio/dio.dart';
import '../../config/const/env/environment.dart';
import '../../domain/dtos/recipe/recipe_dto.dart';

class RecipeDataSource {
  final String _baseUrl = Environment.apiURL;
  final Dio _dio = Dio();

  Future<List<Recipe>> getRecipes() async {
    final recipes = await _dio.get('$_baseUrl/recipes');
    final recipesListCasted = RecipeCaster.toRecipesList(recipes.data);
    return recipesListCasted;
  }

  Future<void> createRecipe(Recipe recipe) async {
    await _dio.post('$_baseUrl/recipes/create',
        data: RecipeCaster.toMap(recipe));
  }

  Future<void> updateRecipe(Recipe recipe) async {
    await _dio.put('$_baseUrl/recipes/${recipe.id}',
        data: RecipeCaster.toMap(recipe));
  }

  Future<void> deleteRecipe(int id) async {
    await _dio.delete('$_baseUrl/recipes/$id');
  }

    Future<List<ScheduleRecipe>> getScheduleRecipes() async {
    final scheduleRecipes = await _dio.get('$_baseUrl/schedule');
    final scheduleRecipesListCasted = ScheduleRecipeCaster.toSchduleRecipesList(scheduleRecipes.data);
    return scheduleRecipesListCasted;
  }

    Future<void> updateScheduleRecipe(ScheduleRecipe schedule) async {
    await _dio.put('$_baseUrl/recipes/update', data: ScheduleRecipeCaster.toMap(schedule));
  }

Future<void> deleteSchduleRecipe(int id) async {
    await _dio.delete('$_baseUrl/recipes/delete/$id');
  }

}
