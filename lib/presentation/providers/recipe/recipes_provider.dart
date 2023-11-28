import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../domain/dtos/recipe/recipe_dto.dart';
import '../../../infrastructure/dataSources/recipe_data_source.dart';
part 'recipes_provider.g.dart';

@riverpod
class Recipes extends _$Recipes {
  Recipes() : super();

  @override
  FutureOr<List<Recipe>> build() async => await getRecipes();

  Future<List<Recipe>> getRecipes() async {
    return await RecipeDataSource().getRecipes();
  }

  Future<int> createRecipe() async {
    return await RecipeDataSource().createRecipe();
  }
}
