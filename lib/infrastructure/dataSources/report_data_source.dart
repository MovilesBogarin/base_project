import 'package:base_project/domain/dtos/schedule_recipe/schedule_recipe_dto.dart';
import 'package:base_project/domain/dtos/scheduled_recipes/checkedList_dto.dart';
import 'package:base_project/domain/dtos/scheduled_recipes/scheduled_recipes_dto.dart';
import 'package:base_project/infrastructure/casters/scheduled_recipe/scheduled_recipe_caster.dart';
import 'package:dio/dio.dart';
import '../../config/const/env/environment.dart';
import '../../domain/dtos/recipe/recipe_dto.dart';

class ReportDataSource {
  final String _baseUrl = Environment.apiURL;
  final Dio _dio = Dio();

  Future<List<ScheduledRecipe>> getReportedRecipes(String date) async {
    final result =
        await _dio.post('$_baseUrl/schedule/by-date', data: {"date": date});
    final scheduledRecipesListCasted =
        ScheduledRecipesCaster.toScheduledRecipeList(result.data);
    // final scheduledRecipesMultiplyQuantity =
    //     ScheduledRecipesCaster.multiplyIngredients(scheduledRecipesListCasted);
    return scheduledRecipesListCasted;
  }

  Future<List<ScheduledRecipe>> getReportedRecipesRange(
      String startDate, String endDate) async {
    final result = await _dio.post('$_baseUrl/schedule/by-range',
        data: {"startDate": startDate, "endDate": endDate});
    final scheduledRecipesListCasted =
        ScheduledRecipesCaster.toScheduledRecipeList(result.data);
    // final scheduledRecipesMultiplyQuantity =
    //     ScheduledRecipesCaster.multiplyIngredients(scheduledRecipesListCasted);
    return scheduledRecipesListCasted;
  }

  Future<void> updateCheckedIngredients(CheckedList checkedList) async {
    final result = await _dio.post('$_baseUrl/schedule/check', data: {
      "bool_value": checkedList.checked,
      "schedule_ingredients": checkedList.listScheduledIngredientsAffected
          .map((scheduledAffected) =>
              ScheduledRecipesCaster.scheduledIngredientAffectedToMap(
                  scheduledAffected))
          .toList()
    });
  }
}
