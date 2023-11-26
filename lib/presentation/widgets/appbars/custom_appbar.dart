import 'package:flutter/material.dart';

mixin CustomAppBar {
  AppBar appBarSimple({String title = '', IconButton? button}) =>
    AppBar(
      title: Text(title),
      automaticallyImplyLeading: false,
      actions: button != null ? [button] : null,
    );
    AppBar appBarWithReturnButton({String title = '', IconButton? button, bool returnButtonEnabled = true}) => AppBar(
      title: Text(title), 
      automaticallyImplyLeading: returnButtonEnabled,
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