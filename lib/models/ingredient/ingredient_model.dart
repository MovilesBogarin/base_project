class IngredientModel {
  String id;
  String name;
  num quantity;
  String unit;

  IngredientModel(
      {required this.id,
      required this.name,
      required this.quantity,
      required this.unit});

  factory IngredientModel.fromJson(Map<String, dynamic> json) =>
      IngredientModel(
        id: json['_id'],
        name: json['name'],
        quantity: json['quantity'],
        unit: json['unit'],
      );
}
