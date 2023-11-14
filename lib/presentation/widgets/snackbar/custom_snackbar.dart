import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void OpenDialog(
  BuildContext context,
  String instructions,
) {
  OpenDialog(context, instructions);
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            title: Text(instructions),
            content: const TextField(
              decoration: InputDecoration(),
            ),
            actions: [
              TextButton(
                  onPressed: () => context.pop(),
                  child: const Text('Cancelar')),
              FilledButton(
                  onPressed: () => context.pop(),
                  child: const Text('Modificar'))
            ],
          ));
}
