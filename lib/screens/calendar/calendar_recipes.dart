import 'package:flutter/material.dart';
import '../../presentation/widgets/appbars/custom_appbar.dart';

class CalenderRecipe extends StatefulWidget {
  const CalenderRecipe({Key? key}) : super(key: key);

  @override
  State<CalenderRecipe> createState() => _CalendarRecipesScreenState();
}

class _CalendarRecipesScreenState extends State<CalenderRecipe>
    with CustomAppBar {
  @override
  Widget build(BuildContext context) {
    // final Recipe recipe = recipes.where((element) => element.id == widget.id).first;
    return Scaffold(
        appBar: appBarWithReturnButton(title: 'CALENDAR AND RECIPES'),
        body: SafeArea(
            child: Center(
          heightFactor: 80.0,
          widthFactor: 90,
          child: Column(
            children: [
              const SizedBox(height: 80),
              Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 229, 195, 166),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )),
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                child: Column(
                  children: [
                    const Text('CALENDAR & RECIPESasdfasasasdasdasd',
                        // ignore: unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings
                        //'${RangeStart != null ? RangeStart!.add(const Duration(days: 1)).fullDate() : ""}  ${RangeFinish != null ? 'to ' + RangeFinish!.add(const Duration(days: 1)).fullDate() : ""}',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: Colors.white)),
                    const SizedBox(height: 30),
                    Container(
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 54, 60, 102),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          )),
                      child: TextButton(
                          style: TextButton.styleFrom(
                              textStyle: const TextStyle(color: Colors.white)),
                          onPressed: () {
                            //context.push('/calendar/recipes');
                          },
                          child: const Text(
                            'Agregar a estos dias :) ',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )));
  }
}
