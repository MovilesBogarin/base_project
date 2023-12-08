import 'package:base_project/domain/dtos/ingredient/ingredient_dto.dart';
import 'package:base_project/domain/dtos/scheduled_recipes/checklist_dto.dart';
import 'package:base_project/domain/dtos/scheduled_recipes/scheduled_ingredient_affected_dto.dart';

import '../../../domain/dtos/recipe/recipe_dto.dart';
import '../../../domain/dtos/scheduled_recipes/scheduled_recipes_dto.dart';
import '../recipe/recipe_caster.dart';

class ScheduledRecipesCaster {
  static List<ScheduledRecipe> toScheduledRecipeList(List<dynamic> list) {
    final List<Map<String, dynamic>> listCasted =
        list.map((x) => x as Map<String, dynamic>).toList();
    return listCasted
        .map((scheduledRecipe) => toScheduledRecipe(scheduledRecipe))
        .toList();
  }

  static ScheduledRecipe toScheduledRecipe(Map<String, dynamic> map) {
    Recipe recipe = RecipeCaster.toRecipe(map['recipe']);
    final listNotCasted = map['checklists'] as List<dynamic>;
    final checklistNotCasted =
        listNotCasted.map((check) => check as Map<String, dynamic>).toList();
    List<Checklist> checklist = toChecklistList(checklistNotCasted);
    return ScheduledRecipe(
        id_schedule: map['id_schedule'],
        id_recipe: map['id_recipe'],
        quantity: map['quantity'],
        date: map['date'],
        recipe: recipe,
        checklists: checklist);
  }

  static List<Recipe> multiplyIngredients(
      List<ScheduledRecipe> scheduledRecipes) {
    List<Recipe> recipesList = scheduledRecipes.map((scheduledRecipe) {
      num cantidad = scheduledRecipe.quantity;
      List<Ingredient> newList =
          scheduledRecipe.recipe.ingredients.map((ingredient) {
        ingredient.quantity = ingredient.quantity * cantidad;
        return ingredient;
      }).toList();
      scheduledRecipe.recipe.ingredients = newList;
      return scheduledRecipe.recipe;
    }).toList();
    return recipesList;
  }

  static Map<String, dynamic> scheduledIngredientAffectedToMap(
      ScheduledIngredientAffected scheduledIngredientAffected) {
    return {
      'id_schedule': scheduledIngredientAffected.id_schedule,
      'ingredientId': scheduledIngredientAffected.ingredientId
    };
  }
}

List<Checklist> toChecklistList(List<Map<String, dynamic>> list) {
  final checklist = list.map((checklist) => toChecklist(checklist)).toList();
  return checklist;
}

Checklist toChecklist(Map<String, dynamic> map) {
  return Checklist(
    ingredientId: map['ingredientId'],
    checked: map['checked'],
  );
}
