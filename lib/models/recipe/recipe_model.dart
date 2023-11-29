import '../../domain/dtos/ingredient/ingredient_dto.dart';
import '../../infrastructure/casters/ingredient/ingredient_caster.dart';

class RecipeModel {
  final int id;
  final String name;
  final String description;
  final List<Ingredient> ingredients;
  final List<String> steps;

  RecipeModel({
    required this.id, 
    required this.name, 
    required this.description,
    required this.ingredients,
    required this.steps,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
    id: json['id'], 
    name: json['name'], 
    description: json['description'],
    ingredients: IngredientCaster.toIngredientsList(json['ingredients']),
    steps: json['steps'], 
  );
}
