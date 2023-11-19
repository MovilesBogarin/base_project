import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:go_router/go_router.dart';
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
  final TextEditingController _recipeNameController = TextEditingController();
  final TextEditingController _recipeDescriptionController = TextEditingController();
  final TextEditingController _ingredientNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> recipe = recipes.where((element) => element['id'] == widget.id).first;
    final List<Map<String,dynamic>> ingredients = recipe['ingredients'];
    
    if (_recipeNameController.text.isEmpty) {
      _recipeNameController.text = recipe['name'];
    }
    if (_recipeDescriptionController.text.isEmpty) {
      _recipeDescriptionController.text = recipe['description'];
    }

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
          TransparentTextBox(
            editable: isEditing,
            controller: _recipeNameController,
            fontSize: 24,
            bold: true,
          ),
          const SizedBox(height: 8),
          TransparentTextBox(
            editable: isEditing,
            controller: _recipeDescriptionController,
            maxLines: 3,
            fontSize: 12,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: [
              ...ingredientsChipsList,
              if (isEditing) IconButton(
                onPressed: () {
                  openDialog(context: context, controller: _ingredientNameController);
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

class TransparentTextBox extends StatelessWidget {
  final bool editable;
  final TextEditingController controller;
  final bool showUnderline;
  final int maxLines;
  final double? fontSize;
  final bool bold;
  final Color color;

  const TransparentTextBox({super.key, this.editable = true, required this.controller, this.showUnderline = true, this.maxLines = 1, this.fontSize, this.bold = false, this.color = Colors.black});  

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: editable,
      maxLines: maxLines,
      minLines: 1,
      decoration: InputDecoration(
        border: editable && showUnderline ? const UnderlineInputBorder() : InputBorder.none,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0)
      ),
      style: TextStyle(fontSize: fontSize, fontWeight: bold ? FontWeight.bold : FontWeight.normal, color: color),
      controller: controller,
    );
  }
}

class UnitsDropdown extends StatelessWidget {
  final bool enabled;
  final Function(String?)? onChanged;
  const UnitsDropdown({super.key, this.enabled = true, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      iconSize: 0,
      items: units.map((String value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: const InputDecoration(labelText: 'Unidad', isDense: true, contentPadding: EdgeInsets.symmetric(vertical: 5)),
    );
  }
}

void openDialog({required BuildContext context, required TextEditingController controller, String? name, num? quantity, String? unit}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: const Text('Ingrediente'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Nombre',
              isDense: true,
            ),
          ),
          Row(
            children: [
              const Expanded(
                flex: 3,
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Cantidad',
                    isDense: true,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: UnitsDropdown(
                  onChanged: (String? value) {
                    print(value);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () => context.pop(),
            child: const Text('Cancelar')),
        FilledButton(
            onPressed: () => context.pop(),
            child: const Text('Guardar cambios'))
      ],
    )
  );
}
