import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String subTitle;
  final String link;
  final IconData icon;

  const MenuItem({
    required this.title,
    required this.subTitle,
    required this.link,
    required this.icon,
  });
}

List<MenuItem> appMenuItems = <MenuItem>[
  const MenuItem(
      title: 'Calendario',
      subTitle: 'Ver y asignar recetas en tu calendario.',
      link: '/widgetTree',
      icon: Icons.calendar_today_rounded),
  const MenuItem(
      title: 'Recetas',
      subTitle: 'Ver y crear recetas.',
      link: '/recipes',
      icon: Icons.restaurant_rounded),
];
