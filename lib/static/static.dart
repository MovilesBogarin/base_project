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
<<<<<<< HEAD
getRecipes() async{

http.Response response =await http.get('http://10.0.2.2/api/recipes/' as Uri);
debugPrint(response.body);

}
=======

final ingredients = <Map<String,dynamic>>[
  {
    'id': 1,
    'name': 'Tomato',
    'quantity': 1,
    'unit': 'pz',
  }, {
    'id': 2,
    'name': 'Pasta',
    'quantity': 300,
    'unit': 'gr',
  }, {
    'id': 3,
    'name': 'Cheese',
    'quantity': 100,
    'unit': 'gr',
  }, {
    'id': 4,
    'name': 'Flour',
    'description': 'Flour',
  }
];
>>>>>>> b3c96b22eaf22fd591c4d9e1d8871aca2aaf40ac
