import 'package:flutter/material.dart';
import 'package:base_project/presentation/widgets/input_text_box.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../config/auth/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 90.0),
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Food Structured',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 40.0,
                      color: colors.primary)),
              const SizedBox(height: 15.0),
              const CircleAvatar(
                radius: 100.0,
                backgroundColor: Colors.white,
                backgroundImage:
                    AssetImage('resources/images/FoodStructuredLogo.png'),
              ),
              const SizedBox(height: 15.0),
              Text(
                isLogin ? 'Iniciar Sesión' : 'Registrarse',
                style: const TextStyle(fontFamily: 'Roboto', fontSize: 35.0),
              ),
              const SizedBox(height: 15.0),
              InputTextBox(
                controller: emailController,
                label: 'Correo electrónico',
                icon: Icons.email,
              ),
              const SizedBox(height: 15.0),
              InputTextBox(
                controller: passwordController,
                label: 'Contraseña',
                icon: Icons.lock,
                hideText: true,
              ),
              TextButton(
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue)),
                onPressed: () {
                  setState(() {
                    isLogin = !isLogin;
                  });
                },
                child: Text(isLogin
                    ? 'Cambiar a registro'
                    : 'Cambiar a inicio de sesión'),
              ),
              const SizedBox(height: 15.0),
              SizedBox(
                child: TextButton(
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue)),
                  onPressed: () {
                    if (isLogin) {
                      signInWithEmailAndPassword();
                    } else {
                      createUserWithEmailAndPassword();
                    }
                  },
                  child: Text(isLogin ? 'Iniciar Sesión' : 'Registrarse'),
                ),
              ),
              Text(errorMessage ?? '',
                  style: const TextStyle(color: Colors.red)),
            ],
          )
        ],
      ),
    );
  }
}
