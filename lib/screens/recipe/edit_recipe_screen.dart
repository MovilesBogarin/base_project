import 'package:base_project/presentation/widgets/snackbar/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/widgets/drawers/custom_drawer.dart';
import '../../presentation/widgets/appbars/custom_appbar.dart';

import '../../static/static.dart';

class EditRecipeScreen extends StatefulWidget {
  final int id;

  const EditRecipeScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<EditRecipeScreen> createState() => _EditRecipeScreenState();
}

class _EditRecipeScreenState extends State<EditRecipeScreen> with CustomAppBar {
  @override
  Widget build(BuildContext context) {
    TextEditingController _controller;

    final Map<String, dynamic> recipe =
        recipes.where((element) => element['id'] == widget.id).first;
    _controller = TextEditingController(text: '${recipe['instructions']}');
    return Scaffold(
      appBar: appBarWithReturnButton(title: recipe['name']),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Text('${recipe['instructions']}'),
              FilledButton(
                onPressed: () {
                  OpenDialog(context, _controller);
                },
                child: const Text('Editar receta'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void OpenDialog(BuildContext context, TextEditingController controller) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            title: const Text('Edición de receta'),
            content: TextFormField(
              controller: controller,
              minLines: 3,
              maxLines: 10,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
            actions: [
              TextButton(
                  onPressed: () => context.pop(),
                  child: const Text('Cancelar')),
              FilledButton(
                  onPressed: () => context.pop(),
                  child: const Text('Guardar cambios'))
            ],
          ));
}
