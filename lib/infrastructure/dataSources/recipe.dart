import 'package:dio/dio.dart';
import '../../config/env/environment.dart';
import '../../domain/dtos/recipe_dto.dart';
import '../mappers/recipes_mapper.dart';

class RecipeDataSource {
  final String _baseUrl = Environment.apiURL;
  final Dio _dio = Dio();

  Future<List<Recipe>> getRecipes() async {
    final recipes = await _dio.get('$_baseUrl/recipes');
    return RecipesMapper.mapRecipes(recipes.data);
  }

  Future<Recipe> getRecipe(int? id) async {
    final recipe = await _dio.get('$_baseUrl/recipes/$id');
    return RecipesMapper.mapRecipe(recipe.data);
  }

  // TODO: Reparar esto
  // Future<Response> createRecipe(Map<String, dynamic> data) async {
  //   return await _dio.post('$_baseUrl/recipes', data: data);
  // }

  // Future<Response> updateRecipe(int? id, Map<String, dynamic> data) async {
  //   return await _dio.put('$_baseUrl/recipes/$id', data: data);
  // }

  // Future<Response> deleteRecipe(int? id) async {
  //   return await _dio.delete('$_baseUrl/recipes/$id');
  // }
}
