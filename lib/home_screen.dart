import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      '¡Bienvenido a la aplicación!',
      style: TextStyle(fontSize: 24),
    ));
  }
}
