import 'package:flutter/material.dart';

class InputTextBox extends StatelessWidget {
  final controller;
  final String? hint;
  final String label;
  final IconData? icon;
  final bool hideText;
  const InputTextBox({super.key, this.hint, this.label = 'Mensaje', this.icon, this.hideText = false, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enableInteractiveSelection: false,
      textCapitalization: TextCapitalization.characters,
      autofocus: true,
      obscureText: hideText,
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        suffixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0))),
    );
  }
}