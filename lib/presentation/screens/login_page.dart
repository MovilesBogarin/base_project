import 'package:base_project/presentation/widgets/input_text_box.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
              Text('Food Structured', style: TextStyle(fontFamily: 'Roboto', fontSize: 50.0, color: colors.primary)),
              const SizedBox(height: 15.0),
              const CircleAvatar(
                radius: 100.0,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('resources/images/FoodStructuredLogo.png'),
              ),
              const SizedBox(height: 15.0),
              const Text('Iniciar Sesión', style: TextStyle(fontFamily: 'Roboto', fontSize: 35.0),
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
              const SizedBox(height: 15.0),
              SizedBox(
                child: TextButton(
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue)),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Summary'),
                        content: Text('Correo: ${emailController.text} \nContraseña: ${passwordController.text}'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: Container(
                              color: Colors.green,
                              padding: const EdgeInsets.all(14),
                              child: const Text('okay'),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text('Sing in'),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
