import 'package:flutter/material.dart';
import '../../presentation/widgets/appbars/custom_appbar.dart';
// import '../../';
// import '../../domain/dtos/recipe_dto.dart';

class EditRecipeScreen extends StatefulWidget {
  final int id;

  const EditRecipeScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<EditRecipeScreen> createState() => _EditRecipeScreenState();
}

class _EditRecipeScreenState extends State<EditRecipeScreen> with CustomAppBar {
  @override
  Widget build(BuildContext context) {
    // final Recipe recipe = recipes.where((element) => element.id == widget.id).first;
    return Scaffold(
      appBar: appBarWithReturnButton(title: 'Nueva receta'),
      body: const SafeArea(
        child: Center(
          child: Text('Editar receta vacia'),
        ),
      ),
    );
  }
}
