import '../../dtos/ingredient/ingredient_dto.dart';

class Recipe {
  String id;
  String name;
  String description;
  List<Ingredient> ingredients;
  List<String> steps;
  List<String> dates;

  Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.ingredients,
    required this.steps,
    required this.dates,
  });
}
