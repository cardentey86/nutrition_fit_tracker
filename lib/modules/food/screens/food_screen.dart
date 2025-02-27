import 'package:flutter/material.dart';

class FoodScreen extends StatelessWidget {
  const FoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Página de Alimentos"),
      ),
      body: const Center(
        child: Text(
          'Aquí van los alimentos.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
