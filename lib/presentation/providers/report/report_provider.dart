import 'package:base_project/domain/dtos/ingredient/ingredient_dto.dart';
import 'package:base_project/domain/dtos/schedule_recipe/schedule_recipe_dto.dart';
import 'package:base_project/domain/dtos/scheduled_recipes/checkedList_dto.dart';
import 'package:base_project/domain/dtos/scheduled_recipes/checklist_dto.dart';
import 'package:base_project/domain/dtos/scheduled_recipes/scheduled_ingredient_affected_dto.dart';
import 'package:base_project/domain/dtos/scheduled_recipes/scheduled_recipes_dto.dart';
import 'package:base_project/infrastructure/dataSources/report_data_source.dart';
import 'package:base_project/infrastructure/dataSources/schedule_recipe_data_source.dart';
import 'package:collection/collection.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/dtos/recipe/recipe_dto.dart';

part 'report_provider.g.dart';

@riverpod
class Report extends _$Report {
  Report() : super();

  // @override
  @override
  // FutureOr<List<CheckedList>> build(String dateInit, String dateEnd) async =>
  //     await getScheduledRecipes(dateInit, dateEnd);
  @override
  FutureOr<List<CheckedList>> build(String dateInit, String dateFinal) async {
    // await getScheduledRecipes(dateInit, dateFinal);
    if (dateFinal != 'null') {
      return getRecipeSum(
          await getReportedRecipesRangeFromDS(dateInit, dateFinal));
    } else {
      return getRecipeSum(await getReportedRecipesFromDS(dateInit));
    }
  }

// Future<List<CheckedList>> getScheduledRecipes(
//     String dateInit, String dateEnd) async {
//   if (dateEnd != 'null') {
//     return getRecipeSum(await getReportedRecipesRangeFromDS(dateInit, dateEnd));
//   } else {
//     return getRecipeSum(await getReportedRecipesFromDS(dateInit));
//   }
// }

  Future<List<ScheduledRecipe>> getReportedRecipesFromDS(String date) async {
    return await ReportDataSource().getReportedRecipes(date);
  }

  Future<List<ScheduledRecipe>> getReportedRecipesRangeFromDS(
      String initDate, String endDate) async {
    return await ReportDataSource().getReportedRecipesRange(initDate, endDate);
  }

  Future<void> updateCheckedIngredients(CheckedList checkedList) async {
    await ReportDataSource().updateCheckedIngredients(checkedList);
  }

  List<CheckedList> getRecipeSum(List<ScheduledRecipe> listScheduledRecipes) {
    List<Ingredient> listIngredientsFinal = [];
    List<CheckedList> listCheckedlistFinal = [];

    for (int i = 0; i < listScheduledRecipes.length; i++) {
      Recipe recipe = listScheduledRecipes[i].recipe;

      List<Ingredient> listIngredient = recipe.ingredients;
      List<Checklist> checklisList = listScheduledRecipes[i].checklists;

      for (int x = 0; x < listIngredient.length; x++) {
        bool encontrado = false;

        if (listCheckedlistFinal.isEmpty) {
          List<ScheduledIngredientAffected> listScheduledIngredientAffected =
              [];
          ScheduledIngredientAffected scheduledIngredientAffected =
              ScheduledIngredientAffected(
                  id_schedule: listScheduledRecipes[i].id_schedule,
                  ingredientId: checklisList[x].ingredientId);
          listScheduledIngredientAffected.add(scheduledIngredientAffected);

          CheckedList checkedList = CheckedList(
              checked: checklisList[x].checked,
              name: listIngredient[x].name,
              unit: listIngredient[x].unit,
              quantity: (listIngredient[x].quantity *
                  listScheduledRecipes[i].quantity),
              listScheduledIngredientsAffected: listScheduledIngredientAffected,
              warning: false,
              date: listScheduledRecipes[i].date);
          listCheckedlistFinal.add(checkedList);
        } else {
          for (int y = 0; y < listCheckedlistFinal.length; y++) {
            if (listIngredient[x].name == listCheckedlistFinal[y].name &&
                listIngredient[x].unit == listCheckedlistFinal[y].unit) {
              listCheckedlistFinal[y].quantity += (listIngredient[x].quantity *
                  listScheduledRecipes[i].quantity);
              ScheduledIngredientAffected scheduledIngredientAffected =
                  ScheduledIngredientAffected(
                      id_schedule: listScheduledRecipes[i].id_schedule,
                      ingredientId: checklisList[x].ingredientId);
              listCheckedlistFinal[y]
                  .listScheduledIngredientsAffected
                  .add(scheduledIngredientAffected);
              if (listCheckedlistFinal[y].date !=
                      listScheduledRecipes[i].date &&
                  checklisList[x].checked != listCheckedlistFinal[y].checked) {
                listCheckedlistFinal[y].warning = true;
              }
              if (checklisList[x].checked == false) {
                listCheckedlistFinal[y].checked = false;
              }
              encontrado = true;
            }
          }
          if (!encontrado) {
            List<ScheduledIngredientAffected> listScheduledIngredientAffected =
                [];
            ScheduledIngredientAffected scheduledIngredientAffected =
                ScheduledIngredientAffected(
                    id_schedule: listScheduledRecipes[i].id_schedule,
                    ingredientId: checklisList[x].ingredientId);
            listScheduledIngredientAffected.add(scheduledIngredientAffected);

            CheckedList checkedList = CheckedList(
                checked: checklisList[x].checked,
                name: listIngredient[x].name,
                unit: listIngredient[x].unit,
                quantity: (listIngredient[x].quantity *
                    listScheduledRecipes[i].quantity),
                listScheduledIngredientsAffected:
                    listScheduledIngredientAffected,
                warning: false,
                date: listScheduledRecipes[i].date);

            listCheckedlistFinal.add(checkedList);
          }
        }
      }
    }

    return listCheckedlistFinal;
  }
}
