import 'dart:async';

import 'package:base_project/domain/dtos/scheduled_recipes/checkedList_dto.dart';
import 'package:base_project/presentation/providers/report/report_provider.dart';
import 'package:base_project/presentation/widgets/loading/loading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class CalenderRecipe extends ConsumerStatefulWidget {
  final String date1;
  final String date2;
  final String? recipeParam;
  const CalenderRecipe(
      {super.key, required this.date1, required this.date2, this.recipeParam});

  @override
  CalendarRecipesScreenState createState() => CalendarRecipesScreenState();
}

class CalendarRecipesScreenState extends ConsumerState<CalenderRecipe>
    with Loading {
  List<bool> selectedStates = [];
  late Future<List<CheckedList>> currentCheckedList;
  @override
  void initState() {
    super.initState();
    ref.read(reportProvider.call(widget.date2, widget.date1).notifier);
  }

  void _mostrarSnackbar(BuildContext context, String mensaje) {
    final snackBar = SnackBar(
      content: Text(mensaje),
      backgroundColor: Colors.orange,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  updateCheckedIngredient(CheckedList checkedList) => ref
      .read(reportProvider.call(widget.date2, widget.date1).notifier)
      .updateCheckedIngredients(checkedList);

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
          error: (error, stack) {
            return Center(
                child: Column(
              children: [Text(error.toString())],
            ));
          },
          data: (listCheckedList) => SafeArea(
            child: Column(
              children: [
                Chip(
                  backgroundColor: const Color.fromARGB(255, 26, 57, 91),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  label: Text(
                    (widget.date1 != 'null')
                        ? '${widget.date2} al ${widget.date1}'
                        : widget.date2,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                if (listCheckedList.isEmpty)
                  const Text('No hay recetas agendadas.',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Expanded(
                  child: ListView.builder(
                    itemCount: listCheckedList.length,
                    itemBuilder: (context, index) {
                      selectedStates.add(false);

                      CheckedList checkedList = listCheckedList[index];

                      return CheckboxListTile(
                        secondary: checkedList.warning
                            ? IconButton(
                                icon: const Icon(Icons.error),
                                color: Colors.orange,
                                iconSize: 30,
                                onPressed: () {
                                  _mostrarSnackbar(
                                      context, 'Producto marcado parcialmente');
                                },
                              )
                            : null,
                        title: Text(
                          checkedList.name,
                          selectionColor: const Color.fromARGB(255, 26, 57, 91),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        value: checkedList.checked,
                        subtitle: Text(
                          '${checkedList.unit}: ${checkedList.quantity}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            checkedList.checked = !checkedList.checked;
                            value = checkedList.checked;

                            updateCheckedIngredient(checkedList);
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
