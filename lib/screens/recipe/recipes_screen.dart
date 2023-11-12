import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/widgets/appbars/custom_appbar.dart';
import '../../presentation/widgets/drawers/custom_drawer.dart';

import '../../static/static.dart';

class RecipesScreen extends StatelessWidget with CustomAppBar, CustomDrawer {
  const RecipesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithMenuButton(title: 'Recetas'),
      drawer: drawerSimple(),
      body: SafeArea(
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            final receta = recipes[index];
            return ListTile(
              title: Text(receta['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(receta['description']),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  context.push('/recipes/${receta['id']}');
                }
              ),
            );
          },
        ),
      ),
    );
  }
}
