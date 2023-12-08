import 'package:base_project/domain/dtos/recipe/recipe_dto.dart';
import 'package:base_project/domain/dtos/scheduled_recipes/checklist_dto.dart';

class ScheduledRecipe {
  int id_schedule;
  int id_recipe;
  num quantity;
  String date;
  Recipe recipe;
  List<Checklist> checklists;

  ScheduledRecipe(
      {required this.id_schedule,
      required this.id_recipe,
      required this.quantity,
      required this.date,
      required this.recipe,
      required this.checklists});
}
