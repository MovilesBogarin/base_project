class IngredientModel {
  int id;
  String name;
  num quantity;
  String unit;

  IngredientModel({required this.id, required this.name, required this.quantity, required this.unit});

  factory IngredientModel.fromJson(Map<String, dynamic> json) => IngredientModel(
    id: json['id'],
    name: json['name'],
    quantity: json['quantity'],
    unit: json['unit'],
  );
}

