import 'package:flutter/material.dart';
import 'package:nutrition_fit_traker/drawer_model.dart';
import 'package:nutrition_fit_traker/routes/app_routes.dart';

final List<ParentItem> drawerMenu = [
  ParentItem(
    title: 'Home',
    icon: const Icon(Icons.business_outlined),
    children: [
      ChildItem(
          icon: const Icon(Icons.home), text: "Home", route: AppRoutes.home),
    ],
  ),
  ParentItem(
    title: 'Alimentos',
    icon: const Icon(Icons.food_bank),
    children: [
      ChildItem(
          icon: const Icon(Icons.food_bank_outlined),
          text: "Listado de Alimentos",
          route: AppRoutes.food),
      /* ChildItem(
          icon: const Icon(Icons.menu_book_outlined),
          text: "Menu",
          route: AppRoutes.storeDeviceStatus) */
    ],
  ),
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
];
