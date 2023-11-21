import 'package:flutter/material.dart';

class Custom_Button extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  const Custom_Button({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext) {
    return FloatingActionButton(
        elevation: 5,
        backgroundColor: Colors.red,
        child: Icon(icon),
        onPressed: onPressed);
  }
}
