import 'package:flutter/material.dart';
import 'package:nutrition_fit_traker/modules/food/models/food_model.dart';
import 'package:nutrition_fit_traker/modules/menu/models/menu.dart';

class AddFoodDialog extends StatefulWidget {
  final List<Menu> menuNames;
  final List<Alimento> alimentos;
  final Function(int, int, double) onAddMenuPlato;
  const AddFoodDialog(
      {super.key,
      required this.menuNames,
      required this.alimentos,
      required this.onAddMenuPlato});

  @override
  _AddFoodDialogState createState() => _AddFoodDialogState();
}

class _AddFoodDialogState extends State<AddFoodDialog> {
  final _formKey = GlobalKey<FormState>();
  String? selectedMeal;
  String? selectedFood;
  String? quantity;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Agregar Alimento'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Seleccionar Plato'),
              items: widget.menuNames.map((menu) {
                return DropdownMenuItem<String>(
                  value: menu.id.toString(),
                  child: Text(menu.nombre),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedMeal = value;
                });
              },
              validator: (value) =>
                  value == null ? 'Por favor seleccionar un plato' : null,
            ),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Buscar Alimento'),
              items: widget.alimentos.map((food) {
                return DropdownMenuItem<String>(
                  value: food.id.toString(),
                  child: Text(food.nombre),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedFood = value;
                });
              },
              validator: (value) =>
                  value == null ? 'Por favor seleccionar un alimento' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Cantidad (g)'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                quantity = value;
              },
              validator: (value) => value == null || value.isEmpty
                  ? 'Por favor ingresar una cantidad'
                  : null,
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          child: const Text('Agregar'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              print(
                  'Plato: $selectedMeal, Alimento: $selectedFood, Cantidad: $quantity g');
              Navigator.of(context).pop();
            }
          },
        ),
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
