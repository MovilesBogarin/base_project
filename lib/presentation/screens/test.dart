import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text('Test page', 
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 40.0,
              ),
            ),
            const SizedBox(height: 15.0),
            TextButton(
              onPressed: () {
                context.go('/login');
              }, 
              child: const Text('Salir')
            ),
          ],
        ),
      ),
    );
  }
}