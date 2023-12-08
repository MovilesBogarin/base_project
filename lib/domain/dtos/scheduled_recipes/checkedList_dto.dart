import 'package:base_project/domain/dtos/scheduled_recipes/scheduled_ingredient_affected_dto.dart';

class CheckedList {
  bool checked;
  String name;
  String unit;
  num quantity;
  List<ScheduledIngredientAffected> listScheduledIngredientsAffected;
  bool warning;
  String date;

  CheckedList({
    required this.checked,
    required this.name,
    required this.unit,
    required this.quantity,
    required this.listScheduledIngredientsAffected,
    required this.warning,
    required this.date,
  });
}
