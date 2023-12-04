import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../presentation/providers/recipe/recipes_provider.dart';
import '../../domain/dtos/recipe/recipe_dto.dart';
import '../../domain/dtos/ingredient/ingredient_dto.dart';
import '../../presentation/widgets/appbars/custom_appbar.dart';
import '../../presentation/widgets/chip/ingredient_chip.dart';
import '../../presentation/widgets/containers/custom_container.dart';

import '../../config/const/enums/units_enum.dart';

class EditRecipeScreen extends ConsumerStatefulWidget {
  final int id;

  const EditRecipeScreen({Key? key, required this.id}) : super(key: key);

  @override
  EditRecipesScreenState createState() => EditRecipesScreenState();
}

class EditRecipesScreenState extends ConsumerState<EditRecipeScreen>
    with CustomAppBar {
  bool isEditing = false;
  late Recipe currentRecipe;

  @override
  void initState() {
    super.initState();
    currentRecipe = ref.read(recipesProvider.notifier).getRecipe(widget.id);
  }

  final TextEditingController _recipeNameController = TextEditingController();
  final TextEditingController _recipeDescriptionController =
      TextEditingController();
  bool recipeHasIngredientChanges = false;

  void updateIngredient(
      Ingredient ingredient, String name, num quantity, String unit) {
    ref.read(recipesProvider.notifier).updateIngredient(
        currentRecipe.id, ingredient.id, name, quantity, unit);
    setState(() {});
  }

  Ingredient createIngredient() =>
      ref.read(recipesProvider.notifier).createIngredient(currentRecipe.id);

  void saveRecipe(String name, String description, List<Ingredient> ingredients,
      List<String> steps) {
    currentRecipe.name = name;
    currentRecipe.description = description;
    currentRecipe.ingredients = ingredients;
    currentRecipe.steps = steps;
    ref.read(recipesProvider.notifier).updateRecipe(currentRecipe);
  }

  @override
  Widget build(BuildContext context) {
    final List<Ingredient> ingredients = currentRecipe.ingredients;
    final List<String> steps = currentRecipe.steps;
    final List<TextEditingController> stepsControllers = steps
        .map((String stepText) => TextEditingController(text: stepText))
        .toList();

    if (_recipeNameController.text.isEmpty) {
      _recipeNameController.text = currentRecipe.name;
    }
    if (_recipeDescriptionController.text.isEmpty) {
      _recipeDescriptionController.text = currentRecipe.description;
    }

    final ingredientsChipsList = ingredients
        .mapIndexed((int index, Ingredient ingredient) => IngredientChip(
              name: ingredient.name,
              quantity: ingredient.quantity,
              unit: ingredient.unit,
              onDelete: isEditing
                  ? () {
                      setState(() {
                        ingredients.removeAt(index);
                      });
                    }
                  : null,
              onTap: isEditing
                  ? () {
                      openDialog(
                          context: context,
                          updateIngredient: updateIngredient,
                          ingredient: ingredient);
                    }
                  : null,
            ))
        .toList();

    return Scaffold(
      appBar: appBarWithReturnButton(
          returnButtonEnabled: !isEditing,
          button: IconButton(
              onPressed: () {
                setState(() {
                  if (isEditing) {
                    final stepsUpdated = stepsControllers
                        .map((TextEditingController controller) =>
                            controller.text)
                        .toList();
                    saveRecipe(
                        _recipeNameController.text,
                        _recipeDescriptionController.text,
                        currentRecipe.ingredients,
                        stepsUpdated);
                  }
                  isEditing = !isEditing;
                });
              },
              icon: Icon(isEditing ? Icons.save : Icons.edit))),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          TransparentTextBox(
            isEditing: isEditing,
            controller: _recipeNameController,
            fontSize: 24,
            bold: true,
          ),
          const SizedBox(height: 8),
          TransparentTextBox(
            isEditing: isEditing,
            controller: _recipeDescriptionController,
            maxLines: 3,
            fontSize: 12,
          ),
          const SizedBox(height: 8),
          const Text('Ingredientes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Wrap(spacing: 4, runSpacing: 4, children: [
            ...ingredientsChipsList,
            if (!isEditing && ingredientsChipsList.isEmpty)
              const Text('No hay ingredientes'),
            if (isEditing)
              IconButton(
                  onPressed: () {
                    openDialog(
                        context: context,
                        updateIngredient: updateIngredient,
                        createIngredient: createIngredient);
                  },
                  icon: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black54,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: Icon(Icons.add, color: Colors.grey[600]),
                  )),
          ]),
          const SizedBox(height: 16),
          const Text('Pasos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          CustomContainer(
            stepsContainers: steps
                .mapIndexed((int index, String element) => StepRow(
                      index: index,
                      controller: stepsControllers[index],
                      isEditing: isEditing,
                      onDelete: () {
                        setState(() {
                          steps.removeAt(index);
                        });
                      },
                    ))
                .toList(),
            isEditing: isEditing,
            onAddStep: () {
              stepsControllers.forEachIndexed(
                  (int index, TextEditingController stepController) {
                steps[index] = stepController.text;
              });
              setState(() {
                steps.add('');
              });
            },
          ),
        ],
      ),
    );
  }
}

class TransparentTextBox extends StatelessWidget {
  final bool isEditing;
  final TextEditingController controller;
  final bool showUnderline;
  final int maxLines;
  final double? fontSize;
  final bool bold;
  final Color color;

  const TransparentTextBox(
      {super.key,
      this.isEditing = true,
      required this.controller,
      this.showUnderline = true,
      this.maxLines = 1,
      this.fontSize,
      this.bold = false,
      this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: isEditing,
      maxLines: maxLines,
      minLines: 1,
      decoration: InputDecoration(
          border: isEditing && showUnderline
              ? const UnderlineInputBorder()
              : InputBorder.none,
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 0, vertical: 0)),
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          color: color),
      controller: controller,
    );
  }
}

class UnitsDropdown extends StatelessWidget {
  final bool enabled;
  final Function(String?)? onChanged;
  final String? initialValue;
  const UnitsDropdown(
      {super.key, this.enabled = true, this.onChanged, this.initialValue});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: initialValue,
      iconSize: 0,
      items: units.map((String value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: const InputDecoration(
          labelText: 'Unidad',
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 5)),
    );
  }
}

class StepRow extends StatelessWidget {
  final int index;
  final TextEditingController controller;
  final bool isEditing;
  final Function()? onDelete;
  const StepRow(
      {super.key,
      required this.index,
      required this.controller,
      this.isEditing = false,
      this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(border: Border.all(color: Colors.black54)),
        height: 32,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${index + 1}.',
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            Expanded(
              child: TransparentTextBox(
                controller: controller,
                isEditing: isEditing,
                showUnderline: false,
                maxLines: 3,
                fontSize: 12,
              ),
            ),
            if (isEditing)
              IconButton(
                  onPressed: onDelete,
                  icon: Icon(Icons.close, color: Colors.grey[600]),
                  iconSize: 16,
                  padding: const EdgeInsets.all(0),
                  visualDensity: VisualDensity.compact),
          ],
        ));
  }
}

void openDialog(
    {required BuildContext context,
    required void Function(
            Ingredient ingredient, String name, num quantity, String unit)
        updateIngredient,
    Ingredient? ingredient,
    Ingredient Function()? createIngredient}) {
  final TextEditingController ingredientNameController =
      TextEditingController(text: ingredient?.name ?? '');
  final TextEditingController ingredientQuantityController =
      TextEditingController(
          text: ingredient?.quantity != null
              ? ingredient!.quantity.toString()
              : '0');
  final TextEditingController ingredientUnitController =
      TextEditingController(text: ingredient?.unit ?? '');
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
                  controller: ingredientNameController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    isDense: true,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextField(
                        controller: ingredientQuantityController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Cantidad',
                          isDense: true,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: UnitsDropdown(
                        initialValue:
                            ingredient?.unit != null ? ingredient!.unit : null,
                        onChanged: (String? value) {
                          ingredientUnitController.text = value!;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text('Cancelar')),
              FilledButton(
                  onPressed: () {
                    if (ingredientNameController.text.isEmpty ||
                        ingredientQuantityController.text.isEmpty ||
                        ingredientUnitController.text.isEmpty) {
                      return;
                    }
                    Ingredient newIngredient;
                    if (ingredient == null) {
                      newIngredient = createIngredient!();
                    } else {
                      newIngredient = ingredient;
                    }
                    updateIngredient(
                        newIngredient,
                        ingredientNameController.text,
                        num.parse(ingredientQuantityController.text),
                        ingredientUnitController.text);
                    context.pop();
                  },
                  child: const Text('Guardar cambios'))
            ],
          ));
}
