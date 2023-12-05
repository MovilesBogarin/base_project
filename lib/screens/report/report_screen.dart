import 'package:base_project/domain/dtos/ingredient/ingredient_dto.dart';
import 'package:base_project/presentation/providers/report/report_provider.dart';
import 'package:base_project/presentation/widgets/loading/loading.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class CalenderRecipe extends ConsumerStatefulWidget {
  final String date1;
  final String date2;
  final String? recipeParam;
  const CalenderRecipe(
      {super.key, required this.date1, required this.date2, this.recipeParam});

  @override
  _CalendarRecipesScreenState createState() => _CalendarRecipesScreenState();
}

class _CalendarRecipesScreenState extends ConsumerState<CalenderRecipe>
    with Loading {
  List<bool> selectedStates = []; // Mover la lista a nivel de clase

  @override
  void initState() {
    super.initState();
    ref.read(reportProvider.call(widget.date2, widget.date1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendario y recetas'),
      ),
      body: Consumer(builder: (context, ref, _) {
        final provider =
            ref.watch(reportProvider.call(widget.date2, widget.date1));

        return provider.when(
          loading: () => loading,
          error: (error, stack) => const Center(child: Text('Error')),
          data: (ingredientScheduled) => SafeArea(
            child: Column(
              children: [
                Chip(
                  backgroundColor: Color.fromARGB(255, 26, 57, 91),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  label: Text(
                    (widget.date1 != 'null')
                        ? '${widget.date2} al ${widget.date1}'
                        : '${widget.date2}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                if (ingredientScheduled.isEmpty)
                  Text('No hay recetas agendadas.',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Expanded(
                  child: ListView.builder(
                    itemCount: ingredientScheduled.length,
                    itemBuilder: (context, index) {
                      selectedStates.add(false);

                      Ingredient ingredient = ingredientScheduled[index];

                      return CheckboxListTile(
                        title: Text(
                          ingredient.name,
                          selectionColor: Color.fromARGB(255, 26, 57, 91),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        value: selectedStates[index],
                        subtitle: Text(
                          '${ingredient.unit}: ${ingredient.quantity}',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            selectedStates[index] = !selectedStates[index];
                            value = selectedStates[index];
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
