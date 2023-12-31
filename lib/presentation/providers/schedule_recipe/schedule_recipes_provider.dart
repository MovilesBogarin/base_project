import 'package:base_project/domain/dtos/schedule_recipe/schedule_recipe_dto.dart';
import 'package:base_project/infrastructure/dataSources/schedule_recipe_data_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'schedule_recipes_provider.g.dart';

@riverpod
class ScheduleRecipes extends _$ScheduleRecipes {
  ScheduleRecipes() : super();

  @override
  Future<List<ScheduleRecipe>> build() async => await getScheduleRecipes();

  Future<List<ScheduleRecipe>> getScheduleRecipes() async {
    return await ScheduleRecipeDataSource().getScheduleRecipes();
  }

  void createSchedule(ScheduleRecipe newSchedule) {
    ScheduleRecipeDataSource().createScheduleRecipe(newSchedule);
    state = AsyncValue.data([...state.asData!.value, newSchedule]);
  }

  Future<void> updateScheduleRecipe(ScheduleRecipe schedule) async {
    await ScheduleRecipeDataSource().updateScheduleRecipe(schedule);
    ScheduleRecipe scheduleToUpdate = state.asData!.value
        .firstWhere((element) => element.id_schedule == schedule.id_schedule);
    scheduleToUpdate.id_schedule = schedule.id_schedule;
    scheduleToUpdate.id_recipe = schedule.id_recipe;
    scheduleToUpdate.quantity = schedule.quantity;
    scheduleToUpdate.date = schedule.date;
    state = AsyncValue.data([...state.asData!.value]);
  }

  void deleteScheduleRecipe(int id) {
    ScheduleRecipeDataSource().deleteSchduleRecipe(id);
    state = AsyncValue.data(
        [...state.asData!.value.where((element) => element.id_schedule != id)]);
  }
}
