import '../../domain/dtos/recipe_dto.dart';
import '../../models/recipe/recipe_model.dart';

class RecipesMapper {
  static List<Recipe> mapRecipes(List<Map<String, dynamic>> recipesList) => recipesList.map(
    (recipe) => mapRecipe(recipe)
  ).toList();

  static Recipe mapRecipe(Map<String, dynamic> recipe) {
    final recipeModel = RecipeModel.fromJson(recipe);
    return Recipe(
      id: recipeModel.id, 
      name: recipeModel.name, 
      description: recipeModel.description
    );
  }
}
