import 'package:flutter/material.dart';

mixin CustomAppBar {
  AppBar appBarSimple({String title = 'no tiene Titulo'}) => AppBar(
        title: Text(title),
        automaticallyImplyLeading:
            false, // Establece esto en false para ocultar el botón de retorno
      );
  AppBar appBarWithReturnButton({String title = 'no tiene Titulo'}) => AppBar(
        title: Text(title),
      );
  AppBar appBarWithMenuButton({String title = 'no tiene Titulo'}) => AppBar(
        title: Text(title),
        backgroundColor: Color.fromARGB(255, 26, 57, 91),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      );
}
