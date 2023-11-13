import 'package:flutter/material.dart';
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
    final Map<String, dynamic> recipe =
        recipes.where((element) => element['id'] == widget.id).first;
    return Scaffold(
      appBar: appBarWithReturnButton(title: recipe['name']),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
              child: Center(
            child: Text('${recipe['instructions']}'),
          ))
          // Container(
          //     margin: EdgeInsets.all(10),
          //     alignment: Alignment.bottomCenter,
          //     child: Center(
          //       child: Text('${recipe['instructions']}'),
          //       // child: Text('Editar receta con id ${recipe['id']}'),
          //     )),
        ],
      )),
    );
  }
}
