import 'package:flutter/material.dart';

class Custom_Button extends StatelessWidget {
  final String txt;
  final VoidCallback? onPressed;
  const Custom_Button({super.key, required this.txt, required this.onPressed});

  @override
  Widget build(context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(
              const Color.fromARGB(255, 229, 195, 166)),
          backgroundColor:
              MaterialStateProperty.all(const Color.fromARGB(255, 54, 60, 102)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ))),
      child: Text(
        txt,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
