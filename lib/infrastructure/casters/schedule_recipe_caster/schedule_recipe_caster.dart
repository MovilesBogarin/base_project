import '../../../domain/dtos/schedule_recipe/schedule_recipe_dto.dart';

class ScheduleRecipeCaster {
  static List<ScheduleRecipe> toSchduleRecipesList(List<dynamic> list) {
    final List<Map<String, dynamic>> listCasted =
        list.map((x) => x as Map<String, dynamic>).toList();
    return listCasted.map((schedule) => toSchedule(schedule)).toList();
  }

  static ScheduleRecipe toSchedule(Map<String, dynamic> map) {
    return ScheduleRecipe(
        id_recipe: map['id_schedule'],
        id_schedule: map['id_recipe'],
        quantity: map['quantity'],
        date: map['date']);
  }

   static Map<String, dynamic> toMap(ScheduleRecipe schedule) {
    return {
      'id_schedule': schedule.id_schedule,
      'id_recipe': schedule.id_recipe,
      'quantity': schedule.quantity,
      'date': schedule.date,
    };
  }
}


  //