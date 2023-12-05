import 'package:base_project/domain/dtos/ingredient/ingredient_dto.dart';
import 'package:base_project/infrastructure/dataSources/report_data_source.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/dtos/recipe/recipe_dto.dart';

part 'report_provider.g.dart';

@riverpod
class Report extends _$Report {
  Report() : super();

  // @override
  @override
  FutureOr<List<Ingredient>> build(String dateInit, String dateEnd) async {
    if (dateEnd != 'null') {
      return getRecipeSum(
          await getReportedRecipesRangeFromDS(dateInit, dateEnd));
    } else {
      return getRecipeSum(await getReportedRecipesFromDS(dateInit));
    }
  }

  Future<List<Recipe>> getReportedRecipesFromDS(String date) async {
    return await ReportDataSource().getReportedRecipes(date);
  }

  Future<List<Recipe>> getReportedRecipesRangeFromDS(
      String initDate, String endDate) async {
    return await ReportDataSource().getReportedRecipesRange(initDate, endDate);
  }

  List<Ingredient> getRecipeSum(List<Recipe> listRecipe) {
    List<Ingredient> listIngredientsFinal = [];

    for (int i = 0; i < listRecipe.length; i++) {
      Recipe recipe = listRecipe[i];
      List<Ingredient> listIngredient = recipe.ingredients;

      for (int x = 0; x < listIngredient.length; x++) {
        bool encontrado = false;

        for (int y = 0; y < listIngredientsFinal.length; y++) {
          if (listIngredient[x].name == listIngredientsFinal[y].name &&
              listIngredient[x].unit == listIngredientsFinal[y].unit) {
            listIngredientsFinal[y].quantity += listIngredient[x].quantity;
            encontrado = true;
            break;
          }
        }
        if (!encontrado) {
          listIngredientsFinal.add(listIngredient[x]);
        }
      }
    }

    return listIngredientsFinal;
  }
}
