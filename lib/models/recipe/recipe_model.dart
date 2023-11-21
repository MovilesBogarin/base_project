class RecipeModel {
  final int id;
  final String name;
  final String description;
  RecipeModel({required this.id, required this.name, required this.description});

  factory RecipeModel.fromJson(Map<String, dynamic> json) => 
    RecipeModel(
      id: json['id'], 
      name: json['name'], 
      description: json['description']
    );
}