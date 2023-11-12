import 'package:flutter/material.dart';

class InputTextBox extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final String label;
  final IconData? icon;
  final IconButton? suffixIcon;
  final bool hideText;
  const InputTextBox({super.key, this.hint, this.label = 'Mensaje', this.icon, this.suffixIcon, this.hideText = false, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enableInteractiveSelection: false,
      obscureText: hideText,
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        suffixIcon: suffixIcon ?? Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
      ),
    );
  }
}