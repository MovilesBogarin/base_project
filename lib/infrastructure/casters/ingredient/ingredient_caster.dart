import '../../../domain/dtos/ingredient/ingredient_dto.dart';

class IngredientCaster {
  static List<Ingredient> toIngredientsList(List<dynamic> list) {
    final List<Map<String, dynamic>> listCasted =
        list.map((x) => x as Map<String, dynamic>).toList();
    return listCasted.map((ingredient) => toIngredient(ingredient)).toList();
  }

  static Ingredient toIngredient(Map<String, dynamic> map) {
    return Ingredient(
      id: map['_id'],
      name: map['name'],
      quantity: map['quantity'],
      unit: map['unit'],
    );
  }
}
