import 'package:flutter/material.dart';
import 'package:nutrition_fit_traker/routes/app_routes.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nutrition Fit Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: AppRoutes.getRoutes(),
      initialRoute: AppRoutes.layout,
    );
  }
}
