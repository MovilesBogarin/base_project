import 'package:base_project/domain/dtos/recipe/recipe_dto.dart';

import '../ingredient/ingredient_dto.dart';

class ScheduledRecipe {
  int id_schedule;
  int id_recipe;
  num quantity;
  String date;
  Recipe recipe;

  ScheduledRecipe({
    required this.id_schedule,
    required this.id_recipe,
    required this.quantity,
    required this.date,
    required this.recipe,
  });
}
