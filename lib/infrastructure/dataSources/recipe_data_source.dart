import 'package:base_project/infrastructure/casters/recipe/recipe_caster.dart';
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

  Future<int> createRecipe() async {
    final result = await _dio.post('$_baseUrl/recipes/create');
    return result.data as int;
  }

  // TODO: Reparar esto
  // Future<Response> updateRecipe(int? id, Map<String, dynamic> data) async {
  //   return await _dio.put('$_baseUrl/recipes/$id', data: data);
  // }

  // Future<Response> deleteRecipe(int? id) async {
  //   return await _dio.delete('$_baseUrl/recipes/$id');
  // }
}
