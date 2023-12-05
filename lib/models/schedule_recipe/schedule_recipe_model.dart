

class ScheduleRecipeModel {
  final int id_schedule;
  final int id_recipe;
  final int quantity;
  final String date;

  ScheduleRecipeModel({
    required this.id_schedule, 
    required this.id_recipe, 
    required this.quantity,
    required this.date,
  });

  factory ScheduleRecipeModel.fromJson(Map<String, dynamic> json) => ScheduleRecipeModel(
 id_recipe: json['id_recipe'],
      id_schedule: json['id_schedule'],
      quantity: json['quantity'],
      date: json['date']
  );
}
