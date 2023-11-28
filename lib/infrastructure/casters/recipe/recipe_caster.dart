import '../ingredient/ingredient_caster.dart';
import '../../../domain/dtos/recipe/recipe_dto.dart';

class RecipeCaster {
  static List<Recipe> toRecipesList(List<dynamic> list) {
    final List<Map<String, dynamic>> listCasted = list.map((x) => x as Map<String, dynamic>).toList();
    return listCasted.map((recipe) => toRecipe(recipe)).toList();
  }

  static Recipe toRecipe(Map<String, dynamic> map) {
    final List<dynamic> ingredientsList = map['ingredients'];
    final List<Map<String, dynamic>>ingredientsListCasted = ingredientsList.map((x) => x as Map<String, dynamic>).toList();
    final ingredients = ingredientsListCasted.map((ingredient) => IngredientCaster.toIngredient(ingredient)).toList();
    final List<dynamic> steps = map['steps'];
    final List<String> stepsList = steps.map((i) => i as String).toList();
    return Recipe(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      ingredients: ingredients,
      steps: stepsList,
    );
  }
}