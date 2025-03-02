import 'package:flutter/material.dart';
import 'package:nutrition_fit_traker/data/database_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseHelper _helper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _helper.database.then((db) {}).catchError((error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Error on init database"),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      '¡Bienvenido a la aplicación!',
      style: TextStyle(fontSize: 24),
    ));
  }
}
