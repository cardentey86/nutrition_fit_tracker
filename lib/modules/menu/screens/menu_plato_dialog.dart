import 'package:flutter/material.dart';
import 'package:nutrition_fit_traker/modules/food/models/food_model.dart';
import 'package:nutrition_fit_traker/modules/menu/models/menu.dart';

import '../models/menu_plato.dart';

class AddFoodDialog extends StatefulWidget {
  final List<Menu> menuNames;
  final List<Alimento> alimentos;
  final Function(MenuPlato?, int, int, double) onAddMenuPlato;
  final String action;
  final String? selectedMenu;
  final MenuPlato? menuPlato;
  const AddFoodDialog(
      {super.key,
      required this.menuNames,
      required this.alimentos,
      required this.onAddMenuPlato,
      required this.action,
      this.menuPlato,
      this.selectedMenu});

  @override
  _AddFoodDialogState createState() => _AddFoodDialogState();
}

class _AddFoodDialogState extends State<AddFoodDialog> {
  final _formKey = GlobalKey<FormState>();
  String? selectedMeal;
  String? selectedFood;
  String? quantity;
  MenuPlato? menuPlato;
  List<Alimento> filteredFoods = [];
  final TextEditingController _alimentoController = TextEditingController();

  @override
  void initState() {
    if (widget.menuPlato != null) {
      selectedMeal = widget.menuPlato!.idMenu.toString();
      selectedFood = widget.menuPlato!.idAlimento.toString();
      quantity = widget.menuPlato!.cantidad.toString();
      menuPlato = widget.menuPlato;
    } else if (widget.selectedMenu != null) {
      selectedMeal = widget.selectedMenu;
    }
    super.initState();
  }

  void _filterFoods(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredFoods = widget.alimentos;
      });
    } else {
      setState(() {
        filteredFoods = widget.alimentos
            .where((food) =>
                food.nombre.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
          widget.action == 'add' ? 'Agregar Alimento' : 'Actualizar Alimento'),
      content: SizedBox(
        width: double.maxFinite,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              menuPlato == null
                  ? DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Seleccionar Plato',
                      ),
                      value: selectedMeal,
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
                      validator: (value) => value == null
                          ? 'Por favor seleccionar un plato'
                          : null,
                    )
                  : TextFormField(
                      initialValue: widget.menuNames
                          .firstWhere(
                              (test) => test.id == widget.menuPlato!.idMenu)
                          .nombre,
                      enabled: false,
                    ),
              menuPlato == null
                  ? TextFormField(
                      controller: _alimentoController,
                      decoration:
                          const InputDecoration(labelText: 'Buscar Alimento'),
                      onChanged: _filterFoods,
                    )
                  : TextFormField(
                      initialValue: widget.alimentos
                          .firstWhere(
                              (test) => test.id == menuPlato!.idAlimento)
                          .nombre,
                      enabled: false,
                    ),
              if (filteredFoods.isNotEmpty)
                SizedBox(
                  height: 150,
                  child: filteredFoods.isNotEmpty
                      ? ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          separatorBuilder: (context, index) =>
                              Divider(height: 1, color: Colors.grey[300]),
                          itemCount: filteredFoods.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(filteredFoods[index].nombre),
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      const Text(
                                        'Caloria',
                                        style: TextStyle(
                                            color: Colors.black38,
                                            fontSize: 11),
                                      ),
                                      Text(filteredFoods[index]
                                          .calorias
                                          .toStringAsFixed(2))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        'Proteína',
                                        style: TextStyle(
                                            color: Colors.black38,
                                            fontSize: 11),
                                      ),
                                      Text(filteredFoods[index]
                                          .proteinas
                                          .toStringAsFixed(2))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        'Carbohidratos',
                                        style: TextStyle(
                                            color: Colors.black38,
                                            fontSize: 11),
                                      ),
                                      Text(filteredFoods[index]
                                          .carbohidratos
                                          .toStringAsFixed(2))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        'Grasas',
                                        style: TextStyle(
                                            color: Colors.black38,
                                            fontSize: 11),
                                      ),
                                      Text(filteredFoods[index]
                                          .grasas
                                          .toStringAsFixed(2))
                                    ],
                                  ),
                                ],
                              ),
                              onTap: () {
                                setState(() {
                                  selectedFood =
                                      filteredFoods[index].id.toString();
                                  _alimentoController.text =
                                      filteredFoods[index]
                                          .nombre; // Actualiza el campo
                                  filteredFoods =
                                      []; // Oculta la lista de sugerencias
                                });
                              },
                            );
                          },
                        )
                      : const Center(
                          child: Text('No hay alimentos disponibles')),
                ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Cantidad (g)'),
                keyboardType: TextInputType.number,
                initialValue:
                    menuPlato == null ? '' : menuPlato!.cantidad.toString(),
                onChanged: (value) {
                  setState(() {
                    quantity = value;
                    if (menuPlato != null && value.isNotEmpty) {
                      menuPlato!.cantidad = double.parse(quantity!);
                    }
                  });
                },
                validator: (value) => value == null || value.isEmpty
                    ? 'Por favor ingresar una cantidad'
                    : null,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: Text(widget.action == 'add' ? 'Agregar' : 'Actualizar'),
          onPressed: () {
            if (_formKey.currentState!.validate() && selectedFood != null) {
              widget.onAddMenuPlato(menuPlato, int.parse(selectedMeal!),
                  int.parse(selectedFood!), double.parse(quantity!));
              //Navigator.of(context).pop();
            } else if (selectedFood == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Por favor seleccionar un alimento')),
              );
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
