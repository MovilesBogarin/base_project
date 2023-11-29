import '../../dtos/ingredient/ingredient_dto.dart';

class Recipe {
  int id;
  String name;
  String description;
  List<Ingredient> ingredients;
  List<String> steps;

  Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.ingredients,
    required this.steps,
  });
}
