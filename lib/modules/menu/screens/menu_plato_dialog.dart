import 'package:easy_localization/easy_localization.dart';
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
  final String? selectedFood;
  final MenuPlato? menuPlato;
  const AddFoodDialog(
      {super.key,
      required this.menuNames,
      required this.alimentos,
      required this.onAddMenuPlato,
      required this.action,
      this.menuPlato,
      this.selectedMenu,
      this.selectedFood});

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
    } else if (widget.selectedFood != null) {
      selectedFood = widget.selectedFood;
      _alimentoController.text = widget.alimentos.first.nombre;
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
      title: Text(widget.action == 'add'
          ? 'menuFood.menuPlatoDialog.titleAdd'.tr()
          : 'menuFood.menuPlatoDialog.titleUpdate'.tr()),
      content: SizedBox(
        width: double.maxFinite,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              menuPlato == null
                  ? DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'menuFood.menuPlatoDialog.select'.tr(),
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
                          ? 'menuFood.menuPlatoDialog.errorSelect'.tr()
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
                      decoration: InputDecoration(
                          labelText: 'menuFood.menuPlatoDialog.search'.tr()),
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
                                      Text(
                                        'general.macro.calory'.tr(),
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
                                      Text(
                                        'general.macro.proteins'.tr(),
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
                                      Text(
                                        'general.macro.carbo'.tr(),
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
                                      Text(
                                        'general.macro.fats'.tr(),
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
                                      filteredFoods[index].nombre;
                                  filteredFoods = [];
                                });
                              },
                            );
                          },
                        )
                      : Center(child: Text('general.noData'.tr())),
                ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'menuFood.menuPlatoDialog.quantity'.tr()),
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
                    ? 'menuFood.menuPlatoDialog.errorQuantity'.tr()
                    : null,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: Text(widget.action == 'add'
              ? 'menuFood.menuPlatoDialog.btnAdd'.tr()
              : 'menuFood.menuPlatoDialog.btnUpdate'.tr()),
          onPressed: () {
            if (_formKey.currentState!.validate() && selectedFood != null) {
              widget.onAddMenuPlato(menuPlato, int.parse(selectedMeal!),
                  int.parse(selectedFood!), double.parse(quantity!));
            } else if (selectedFood == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('menuFood.menuPlatoDialog.errorSelectFood')),
              );
            }
          },
        ),
        TextButton(
          child: Text('menuFood.menuPlatoDialog.btnCancel'.tr()),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
