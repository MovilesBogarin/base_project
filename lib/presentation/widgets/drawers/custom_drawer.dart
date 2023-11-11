import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../config/menu/menu_items.dart';

mixin CustomDrawer {
  Widget menuList(BuildContext context, int index) {
    final menuItem = appMenuItems[index];
    return _CustomListTitle(menuItem: menuItem);
  }

  Drawer drawerSimple() =>
    Drawer(
      child: SafeArea(
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: menuList,
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