import 'package:flutter/material.dart';
import 'package:nutrition_fit_traker/modules/configuration/screens/config.dart';
import 'package:nutrition_fit_traker/modules/indices/screens/home_screen.dart';
import 'package:nutrition_fit_traker/modules/information/screens/information.dart';
import 'package:nutrition_fit_traker/modules/layout/screens/layout_screen.dart';
import 'package:nutrition_fit_traker/modules/food/screens/food_screen.dart';
import 'package:nutrition_fit_traker/modules/personal_measure/screens/personal_measure.dart';

class RouterHandler extends StatelessWidget {
  const RouterHandler({
    super.key,
    required String selectedRoute,
  }) : _selectedRoute = selectedRoute;

  final String _selectedRoute;

  @override
  Widget build(BuildContext context) {
    switch (_selectedRoute) {
      case '/home':
        return const HomeScreen();
      case '/layout':
        return const LayoutScreen();
      case '/food':
        return const FoodScreen();
      case '/personalMeasure':
        return const MedidasPersonales();
      case '/information':
        return const Information();
      case '/configuration':
        return const ConfigScreen();
      default:
        return const HomeScreen();
    }
  }
}
