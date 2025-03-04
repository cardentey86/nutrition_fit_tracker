import 'package:flutter/material.dart';
import 'package:nutrition_fit_traker/modules/indices/screens/home_screen.dart';
import 'package:nutrition_fit_traker/modules/information/screens/information.dart';
import 'package:nutrition_fit_traker/modules/layout/screens/layout_screen.dart';
import 'package:nutrition_fit_traker/modules/food/screens/food_screen.dart';
import 'package:nutrition_fit_traker/modules/personal_measure/screens/personal_measure.dart';

class AppRoutes {
  static const String layout = '/layout';
/*   static const String splash = '/splash'; */
  static const String home = '/home';
  static const String food = '/food';
  static const String personalMeasure = '/personalMeasure';
  static const String information = '/information';

  //static final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      //splash: (context) => const SplashScreen(),
      layout: (context) => const LayoutScreen(),
      home: (context) => const HomeScreen(),
      food: (context) => const FoodScreen(),
      personalMeasure: (context) => const MedidasPersonales(),
      information: (context) => const Information(),
    };
  }

  static Future<String> getInitialScreen(BuildContext context) async {
    return home;
  }
}
