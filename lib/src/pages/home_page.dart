import 'package:flutter/material.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  late String _nombre;
  late String _email;
  late String _pass;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 90.0),
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 100.0,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('resources/images/Logo_Test.png'),
              ),
              const Text(
                'Login',
                style: TextStyle(fontFamily: 'Roboto', fontSize: 50.0),
              ),
              const SizedBox(
                width: 160.0,
                height: 15.0,
                child: Divider(
                  color: Color.fromARGB(255, 31, 30, 30),
                ),
              ),
              TextField(
                enableInteractiveSelection: false,
                textCapitalization: TextCapitalization.characters,
                autofocus: true,
                decoration: InputDecoration(
                    hintText: 'Username',
                    labelText: 'User Name',
                    suffixIcon: const Icon(Icons.verified_user),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0))),
                onSubmitted: (valor) {
                  _nombre = valor;
                  print("El nombre es: " + _nombre);
                },
              ),
              const Divider(
                height: 18.0,
              ),
              TextField(
                enableInteractiveSelection: false,
                textCapitalization: TextCapitalization.characters,
                autofocus: true,
                decoration: InputDecoration(
                    hintText: 'E-mail;',
                    labelText: 'E-mail',
                    suffixIcon: Icon(Icons.alternate_email_sharp),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0))),
                onSubmitted: (valor) {
                  _email = valor;
                  print("El nombre es: " + _email);
                },
              ),
              const Divider(
                height: 18.0,
              ),
              TextField(
                obscureText: true,
                enableInteractiveSelection: false,
                textCapitalization: TextCapitalization.characters,
                autofocus: true,
                decoration: InputDecoration(
                    hintText: 'Password',
                    labelText: 'Password',
                    suffixIcon: const Icon(Icons.lock_clock_outlined),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0))),
                onSubmitted: (valor) {
                  _email = valor;
                  print("El password es: " + _pass);
                },
              ),
              const Divider(
                height: 18.0,
              ),
              SizedBox(
                child: TextButton(
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue)),
                  onPressed: () {},
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
