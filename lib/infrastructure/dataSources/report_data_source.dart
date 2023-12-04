import 'package:base_project/infrastructure/casters/recipe/recipe_caster.dart';
import 'package:base_project/infrastructure/casters/scheduled_recipe/scheduled_recipe_caster.dart';
import 'package:dio/dio.dart';
import '../../config/const/env/environment.dart';
import '../../domain/dtos/recipe/recipe_dto.dart';

class ReportDataSource {
  final String _baseUrl = Environment.apiURL;
  final Dio _dio = Dio();

  Future<List<Recipe>> getReportedRecipes(String date) async {
    final result = await _dio.post('$_baseUrl/schedule/by-date',
        //enviar variable
        data: {"date": date});
    final scheduledRecipesListCasted =
        ScheduledRecipesCaster.toScheduledRecipeList(result.data);
    final scheduledRecipesMultiplyQuantity =
        ScheduledRecipesCaster.multiplyIngredients(scheduledRecipesListCasted);
    return scheduledRecipesMultiplyQuantity;
  }

  Future<List<Recipe>> getReportedRecipesRange(
      String startDate, String endDate) async {
    final result = await _dio.post('$_baseUrl/schedule/by-range',
        //enviar variable
        data: {"startDate": startDate, "endDate": endDate});
    final scheduledRecipesListCasted =
        ScheduledRecipesCaster.toScheduledRecipeList(result.data);
    final scheduledRecipesMultiplyQuantity =
        ScheduledRecipesCaster.multiplyIngredients(scheduledRecipesListCasted);
    return scheduledRecipesMultiplyQuantity;
  }
}
