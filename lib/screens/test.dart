import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../config/auth/auth.dart';

class Test extends StatelessWidget {
  Test({super.key});

  final User? user = Auth().currentUser;
  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(user?.email ?? 'No email', 
              style: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 40.0,
              ),
            ),
            const SizedBox(height: 15.0),
            TextButton(
              onPressed: () {
                signOut();
                context.go('/login');
              }, 
              child: const Text('LogOut')
            ),
          ],
        ),
      ),
    );
  }
}