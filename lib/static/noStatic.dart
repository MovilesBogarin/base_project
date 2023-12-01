import '../config/auth/auth.dart';
import 'package:base_project/models/recipe/recipe_model.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;

final String? email = Auth().currentUser?.email;

late final String data;

Future<List<RecipeModel>> getRecipesApi() async {
  final response = await http.get(Uri.parse(
      'https://render-foodstructured.onrender.com/api/recipes/$email'));
  List<RecipeModel> recipesApi = [];
  String body = utf8.decode(response.bodyBytes);
  final jsonData = jsonDecode(body);

  for (var item in jsonData['recipes']) {
    recipesApi.add(RecipeModel(
        id: item['_id'],
        name: item['name'],
        description: item['description'],
        ingredients: [],
        steps: [],
        dates: []));
  }

  return recipesApi;
}
