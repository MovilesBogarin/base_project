import '../ingredient/ingredient_caster.dart';
import '../../../domain/dtos/recipe/recipe_dto.dart';

class RecipeCaster {
  static List<Recipe> toRecipesList(List<dynamic> list) {
    final List<Map<String, dynamic>> listCasted =
        list.map((x) => x as Map<String, dynamic>).toList();
    return listCasted.map((recipe) => toRecipe(recipe)).toList();
  }

  static Recipe toRecipe(Map<String, dynamic> map) {
    final List<dynamic> ingredientsList = map['ingredients'];
    final List<Map<String, dynamic>> ingredientsListCasted =
        ingredientsList.map((x) => x as Map<String, dynamic>).toList();

    final ingredients = ingredientsListCasted
        .map((ingredient) => IngredientCaster.toIngredient(ingredient))
        .toList();

    /*
    final List<dynamic> steps = map['steps'];
    final List<String> stepsList = steps.map((i) => i as String).toList();
*/

    List<String> stepsList = [];

    final List<dynamic>? steps = map['steps'];

// Verifica si steps no es nulo
    if (steps != null) {
      // Utiliza map para convertir elementos a cadenas si es posible
      final List<String> aux = steps.map((d) => d is String ? d : '').toList();
      stepsList = aux;

      // Ahora puedes usar aux de manera segura
    } else {
      // Manejar el caso en el que steps es nulo
    }

    final List<dynamic>? dates = map['dates'];
    List<String> datesList = [];
    if (dates != null) {
      final List<String> aux = dates.map((d) => d is String ? d : '').toList();
      datesList = aux;
      // Ahora puedes usar datesList de manera segura
    } else {
      // Manejar el caso en el que dates es nulo
    }

    return Recipe(
        id: map['_id'],
        name: map['name'],
        description: map['description'],
        ingredients: ingredients,
        steps: stepsList,
        dates: datesList);
  }
}
