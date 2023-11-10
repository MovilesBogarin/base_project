import 'package:base_project/presentation/widget_tree.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../screens/index.dart';

final GoRouter router = GoRouter(
  initialLocation: '/widgetTree',
  routes: <RouteBase>[
    GoRoute(
      path: '/widgetTree',
      builder: (BuildContext context, GoRouterState state) {
        return const WidgetTree();
      },
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: '/calendar',
      builder: (BuildContext context, GoRouterState state) {
        return const CalendarScreen();
      },
    ),
  ],
);
