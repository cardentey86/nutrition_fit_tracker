import 'package:flutter/material.dart';
import 'package:nutrition_fit_traker/modules/layout/models/drawer_model.dart';
import 'package:nutrition_fit_traker/routes/app_routes.dart';

final List<ChildItem> drawerMenu = [
  ChildItem(
      icon: const Icon(Icons.people_alt_outlined),
      text: 'menu.personalIndex',
      route: AppRoutes.home),
  ChildItem(
    icon: const Icon(Icons.menu_book_outlined),
    text: 'menu.menu',
    route: AppRoutes.menu,
  ),
  ChildItem(
      icon: const Icon(Icons.dinner_dining),
      text: "menu.food",
      route: AppRoutes.food),
  ChildItem(
      icon: const Icon(Icons.assignment),
      text: 'menu.personalMeasure',
      route: AppRoutes.personalMeasure),
  ChildItem(
      icon: const Icon(Icons.show_chart),
      text: 'menu.personalProgress',
      route: AppRoutes.progress),
  ChildItem(
      icon: const Icon(Icons.settings),
      text: "menu.configuration",
      route: AppRoutes.configuration),
  ChildItem(
      icon: const Icon(Icons.info_outline),
      text: "menu.information",
      route: AppRoutes.information),
];
