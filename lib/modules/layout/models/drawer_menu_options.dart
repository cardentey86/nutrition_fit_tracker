import 'package:flutter/material.dart';
import 'package:nutrition_fit_traker/modules/layout/models/drawer_model.dart';
import 'package:nutrition_fit_traker/routes/app_routes.dart';

final List<ChildItem> drawerMenu = [
  ChildItem(
      icon: const Icon(Icons.people_alt_outlined),
      text: "Indices Personales",
      route: AppRoutes.home),
  ChildItem(
    icon: const Icon(Icons.menu_book_outlined),
    text: "Menu",
    route: AppRoutes.food,
  ),
  ChildItem(
      icon: const Icon(Icons.dinner_dining),
      text: "Alimentos",
      route: AppRoutes.food),
  ChildItem(
      icon: const Icon(Icons.assignment),
      text: "Medidas Personales",
      route: AppRoutes.personalMeasure),
  ChildItem(
      icon: const Icon(Icons.settings),
      text: "Configuración",
      route: AppRoutes.configuration),
  ChildItem(
      icon: const Icon(Icons.info_outline),
      text: "Información",
      route: AppRoutes.information),
];

  /* ParentItem(
    title: 'Clients',
    icon: const Icon(Icons.business_outlined),
    children: [
      ChildItem(
          icon: const Icon(Icons.person_pin_circle_outlined),
          text: "Client",
          route: AppRoutes.client),
      ChildItem(
          icon: const Icon(Icons.panorama_wide_angle_rounded),
          text: "Ticket",
          route: AppRoutes.ticket),
    ],
  ),
  ParentItem(
    title: 'Users',
    icon: const Icon(Icons.person_outline_outlined),
    children: [
      ChildItem(
          icon: const Icon(Icons.people_outline),
          text: "Users",
          route: AppRoutes.user),
      ChildItem(
          icon: const Icon(Icons.shield_outlined),
          text: "Security Profiles",
          route: AppRoutes.profile),
    ],
  ), */

