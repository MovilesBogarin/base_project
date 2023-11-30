import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

final recipes = <Map<String, dynamic>>[
  {
    'id': 1,
    'name': 'Pasta',
    'description': 'Pasta with tomato sauce',
    'ingredients': <Map<String, dynamic>>[
      {'name': 'Pasta', 'quantity': 200, 'unit': 'gr'},
      {'name': 'Tomato', 'quantity': 2, 'unit': 'u'},
      {'name': 'Salt', 'quantity': 1, 'unit': 'pz'},
      {'name': 'Pepper', 'quantity': 1, 'unit': 'pz'},
    ],
    'steps': <String>[
      'Boil the water',
      'Add the pasta',
      'Cook it',
      'Add the tomato sauce',
      'Add the salt and pepper',
    ]
  },
  {
    'id': 2,
    'name': 'Pizza',
    'description': 'Pizzona with tomato sauce',
    'ingredients': <Map<String, dynamic>>[
      {'name': 'Flour', 'quantity': 200.5, 'unit': 'gr'},
      {'name': 'Tomato', 'quantity': 2, 'unit': 'u'},
      {'name': 'Salt', 'quantity': 1, 'unit': 'pz'},
      {'name': 'Pepperoni', 'quantity': 60, 'unit': 'gr'},
    ],
    'steps': <String>[
      'Make the dough',
      'Add the tomato sauce',
      'Add the pepperoni',
      'Bake it',
    ]
  }
];

final units = <String>[
  'pz',
  'gr',
  'ml',
  'oz',
  'tz',
  'u',
  'cda',
  'cdta',
  'l',
  'kg',
  'lb',
  'gal',
];
