import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import '../../presentation/widgets/appbars/custom_appbar.dart';
import '../../presentation/widgets/chip/ingredient_chip.dart';

import '../../static/static.dart';

class EditRecipeScreen extends StatefulWidget {
  final int id;

  const EditRecipeScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<EditRecipeScreen> createState() => _EditRecipeScreenState();
}

class _EditRecipeScreenState extends State<EditRecipeScreen> with CustomAppBar {
  bool isEditing = false;
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> recipe = recipes.where((element) => element['id'] == widget.id).first;
    final List<Map<String,dynamic>> ingredients = recipe['ingredients'];

    final ingredientsChipsList = ingredients.mapIndexed((int index, Map<String,dynamic> ingrediente) =>
      IngredientChip(
        name: ingrediente['name'],
        quantity: ingrediente['quantity'],
        unit: ingrediente['unit'],
        onDelete: isEditing ? () {
          setState(() {
            ingredients.removeAt(index);
          });
        } : null,
      )).toList(); 

    return Scaffold(
      appBar: appBarWithReturnButton( 
        button: IconButton(onPressed: () {
          setState(() {
            isEditing = !isEditing;
          });
        }, 
        icon: Icon(isEditing ? Icons.save : Icons.edit))
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          TextField(
            enabled: isEditing,
            decoration: InputDecoration(
              border: isEditing ? const UnderlineInputBorder() : InputBorder.none,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0)
            ),
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
            controller: TextEditingController(text: recipe['name']),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: [
              ...ingredientsChipsList,
              if (isEditing) IconButton(
                onPressed: () {
                  print('Add ingredient');
                }, 
                icon: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black54,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(20))
                  ),
                  child: Icon(Icons.add, color: Colors.grey[600]),
                )
              ),
            ]
          ),
          const SizedBox(height: 16),
          Text('Editar receta con id ${recipe['id']}')
        ],
      ),
    );
  }
}
