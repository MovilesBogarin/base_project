import '../../dtos/ingredient/ingredient_dto.dart';

class Recipe {
  final int id;
  final String name;
  final String description;
  final List<Ingredient> ingredients;
  final List<String> steps;

  Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.ingredients,
    required this.steps,
  });
}
