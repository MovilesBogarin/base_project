import 'package:flutter/material.dart';

mixin Loading {
  Widget loading = const Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 20),
          Text('Estamos cocinando tu pantalla, espera por favor.'),
        ],
      ),
    ),
  );
}
