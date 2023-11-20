import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

final recipes = <Map<String,dynamic>>[
  {
    'id': 1,
    'name': 'Pasta',
    'description': 'Pasta with tomato sauce',
  }, {
    'id': 2,
    'name': 'Pizza',
    'description': 'Pizza with tomato sauce',
  }
];
getRecipes() async{

http.Response response =await http.get('http://10.0.2.2/api/recipes/' as Uri);
debugPrint(response.body);

}