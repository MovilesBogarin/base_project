import '../../static/static.dart';
import '../../domain/dtos/recipe_dto.dart';
import '../../models/recipe/recipe_model.dart';

class FoodStructuredAPI {
  List<Recipe> getRecipes() {
    return recipes.map((recipe) { 
      final recipeModel = RecipeModel.fromJson(recipe);
      return Recipe(id: recipeModel.id, name: recipeModel.name, description: recipeModel.description);
    }).toList();
  }

  Recipe addRecipe() {
    final newRecipe = {
      'id': recipes.length + 1,
      'name': 'Receta ${recipes.length + 1}',
      'description': 'Descripción de la receta ${recipes.length + 1}',
    };
    recipes.add(newRecipe);
    final recipeModel = RecipeModel.fromJson(newRecipe);
    return Recipe(id: recipeModel.id, name: recipeModel.name, description: recipeModel.description);
  }
}
