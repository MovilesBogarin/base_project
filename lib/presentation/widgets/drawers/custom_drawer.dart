import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../providers/login_provider.dart';
import '../../../config/menu/menu_items.dart';

mixin CustomDrawer {
  Widget menuList(BuildContext context, int index) {
    final menuItem = appMenuItems[index];
    return _CustomListTitle(menuItem: menuItem);
  }

  Drawer drawerSimple(BuildContext context) => Drawer(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: appMenuItems.length,
                  itemBuilder: menuList,
                ),
              ),
              TextButton(onPressed: () {
                LoginProvider.signOut();
                context.go('/widgetTree');
              }, 
              child: const Text('Cerrar sesión', style: TextStyle(fontWeight: FontWeight.bold),))
            ]
          ),
        ),
      );
}

class _CustomListTitle extends StatelessWidget {
  const _CustomListTitle({
    required this.menuItem,
  });

  final MenuItem menuItem;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ListTile(
      leading: Icon(menuItem.icon, color: colors.primary),
      trailing: Icon(Icons.arrow_forward_ios_rounded, color: colors.primary),
      title: Text(menuItem.title),
      subtitle: Text(menuItem.subTitle),
      onTap: () {
        context.go(menuItem.link);
      },
    );
  }
}
