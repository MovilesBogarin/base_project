import '../../config/helpers/api.dart';
import '../../domain/dtos/recipe_dto.dart';

class RecipesPresenter {
  List<Recipe> getRecipes() {
    return FoodStructuredAPI().getRecipes();
  }

  Recipe addRecipe() {
    return FoodStructuredAPI().addRecipe();
  }
}
