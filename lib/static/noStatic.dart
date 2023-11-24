import 'package:base_project/config/auth/auth.dart';

import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;

late Map data;
final String? email = Auth().currentUser?.email;

getRecipesApi() async {
  final response = await http.get(Uri.parse(
      'https://render-foodstructured.onrender.com/api/recipes/$email'));
  debugPrint(response.body);
  print("Aqui veremos que pasa: " + response.body + '$email');
  data = json.decode(response.body);
  return data;
}

final recipesApi = getRecipesApi();
