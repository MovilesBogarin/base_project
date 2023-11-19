import 'package:flutter/material.dart';

mixin CustomAppBar {
  AppBar appBarSimple({String title = '', IconButton? button}) =>
    AppBar(
      title: Text(title),
      automaticallyImplyLeading: false, // Establece esto en false para ocultar el botón de retorno
      actions: button != null ? [button] : null,
    );
    AppBar appBarWithReturnButton({String title = '', IconButton? button}) => AppBar(
      title: Text(title), 
      actions: button != null ? [button] : null,
    );
    AppBar appBarWithMenuButton({String title = '', IconButton? button}) => AppBar(
      title: Text(title),
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () { Scaffold.of(context).openDrawer(); },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
      actions: button != null ? [button] : null,
    );
}