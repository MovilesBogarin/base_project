import 'package:base_project/domain/dtos/schedule_recipe/schedule_recipe_dto.dart';

import 'package:base_project/infrastructure/casters/schedule_recipe_caster/schedule_recipe_caster.dart';
import 'package:dio/dio.dart';
import '../../config/const/env/environment.dart';

class ScheduleRecipeDataSource {
  final String _baseUrl = Environment.apiURL;
  final Dio _dio = Dio();

  Future<List<ScheduleRecipe>> getScheduleRecipes() async {
    final scheduleRecipes = await _dio.get('$_baseUrl/schedule');
    final scheduleRecipesListCasted =
        ScheduleRecipeCaster.toSchduleRecipesList(scheduleRecipes.data);
    return scheduleRecipesListCasted;
  }

  Future<void> updateScheduleRecipe(ScheduleRecipe schedule) async {
    await _dio.put('$_baseUrl/schedule/update',
        data: ScheduleRecipeCaster.toMap(schedule));
  }

  Future<void> deleteSchduleRecipe(int id) async {
    await _dio.delete('$_baseUrl/schedule/delete/$id');
  }

  Future<void> createScheduleRecipe(ScheduleRecipe schedule) async {
    await _dio.post('$_baseUrl/schedule/create',
        data: ScheduleRecipeCaster.toMap(schedule));
  }
}
