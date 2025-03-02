import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:nutrition_fit_traker/modules/food/infrastructure/food_controller.dart';
import 'package:nutrition_fit_traker/modules/food/models/alimento.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

List<String> _orderOptions = ['asc', 'desc'];

class _FoodScreenState extends State<FoodScreen> {
  final FoodController _foodController = FoodController();

  List<Alimento> _alimentos = [];
  List<Alimento> _filteredAlimentos = [];
  final TextEditingController _searchController = TextEditingController();
  String _filter = "";
  bool isLoading = false;
  List<Slidable> _items = [];
  String currentOrderOption = _orderOptions[0];
  final List<DropdownMenuItem> _orderFields = [
    const DropdownMenuItem(value: 'nombre', child: Text('Nombre')),
    const DropdownMenuItem(value: 'proteina', child: Text('Proteína')),
    const DropdownMenuItem(
        value: 'carbohidratos', child: Text('Carbohidratos')),
    const DropdownMenuItem(value: 'grasas', child: Text('Grasas')),
    const DropdownMenuItem(value: 'fibra', child: Text('Fibra')),
    const DropdownMenuItem(value: 'calorias', child: Text('Calorías'))
  ];
  String orderSelectedField = 'nombre';
  final _formKey = GlobalKey<FormState>();
  Alimento? alimentoToUpdate;

  @override
  void initState() {
    super.initState();
    _loadAlimentos();
  }

  Future<void> _loadAlimentos() async {
    List<Alimento> alimentos = await _foodController.getAlimentos();

    setState(() {
      _alimentos = alimentos;
      _filteredAlimentos = [..._alimentos];
      setData();
    });
  }

  void setData() {
    setState(() {
      _items = [
        ..._filteredAlimentos.asMap().entries.map((entry) {
          Alimento alimento = entry.value;
          return Slidable(
            key: Key(alimento.id.toString()),
            startActionPane: ActionPane(
              extentRatio: 0.4,
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  spacing: 2,
                  backgroundColor: Colors.transparent,
                  padding: const EdgeInsets.all(8.0),
                  label: "Edit",
                  foregroundColor: Colors.blue,
                  icon: Icons.edit,
                  onPressed: (context) async {
                    setState(() {
                      alimentoToUpdate = alimento;
                    });
                    await _formAlimento('update');
                  },
                ),
                SlidableAction(
                  spacing: 2,
                  padding: const EdgeInsets.all(8.0),
                  backgroundColor: Colors.transparent,
                  label: "Add Menú",
                  foregroundColor: Colors.green,
                  icon: Icons.add_box,
                  onPressed: (context) {
                    showSnackBar(context, "Add Menu");
                  },
                )
              ],
            ),
            endActionPane: ActionPane(
              extentRatio: 0.2,
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  spacing: 2,
                  padding: const EdgeInsets.all(8.0),
                  label: "Eliminar",
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.red,
                  icon: Icons.delete,
                  onPressed: (context) async {
                    final shouldDelete = await showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Confirmar eliminación'),
                          content: Text(
                              '¿Está seguro de que desea eliminar el alimento ${alimento.nombre}?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(false); // Cerrar y devolver false
                              },
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(true); // Cerrar y devolver verdadero
                              },
                              child: const Text('Confirmar'),
                            ),
                          ],
                        );
                      },
                    );

                    if (shouldDelete == true) {
                      _foodController.eliminarAlimento(alimento.id!);
                      setState(() {
                        _filteredAlimentos.removeWhere(
                            (element) => element.id == alimento.id);
                      });
                      setData();
                    }
                  },
                ),
              ],
            ),
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    alimento.nombre,
                    style: const TextStyle(
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Calorías',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text('${alimento.calorias} Kcal',
                              style: const TextStyle(color: Colors.black87)),
                        ],
                      ),
                      Column(
                        children: [
                          const Text('Proteínas',
                              style: TextStyle(color: Colors.grey)),
                          Text('${alimento.proteinas}g',
                              style: const TextStyle(color: Colors.black87)),
                        ],
                      ),
                      Column(
                        children: [
                          const Text('Carbohidratos',
                              style: TextStyle(color: Colors.grey)),
                          Text('${alimento.carbohidratos}g',
                              style: const TextStyle(color: Colors.black87)),
                        ],
                      ),
                      Column(
                        children: [
                          const Text('Grasas',
                              style: TextStyle(color: Colors.grey)),
                          Text('${alimento.grasas}g',
                              style: const TextStyle(color: Colors.black87)),
                        ],
                      ),
                      Column(
                        children: [
                          const Text('Fibra',
                              style: TextStyle(color: Colors.grey)),
                          Text('${alimento.fibra}g',
                              style: const TextStyle(color: Colors.black87)),
                        ],
                      ),
                    ],
                  ),
                ),
                if (alimento.nombre !=
                    _filteredAlimentos[_filteredAlimentos.length - 1]
                        .nombre) // Evita el separador en el último elemento
                  const Divider(
                    color: Colors.blueGrey,
                  ),
              ],
            ),
          );
        })
      ];
    });
  }

  Future<void> _restartAlimentos() async {
    // Mostrar un cuadro de diálogo de confirmación
    if (await _foodController.any()) {
      await showDialog<bool>(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirmar actualización'),
            content: const Text(
                '¿Está seguro de que desea reiniciar la base de datos de alimentos? Esta acción eliminará todos los alimentos existentes.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pop(false); // Cerrar el diálogo y devolver falso
                },
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  _reiniciarAlimentos();
                  Navigator.of(context)
                      .pop(true); // Cerrar el diálogo y devolver verdadero
                },
                child: const Text('Confirmar'),
              ),
            ],
          );
        },
      );
    } else {
      _reiniciarAlimentos();
    }
  }

  void _reiniciarAlimentos() async {
    setState(() {
      isLoading = true;
    });
    await _foodController.reiniciarAlimentos();
    await _loadAlimentos();
    setData();
    setState(() {
      isLoading = false;
    });
  }

  void _filterAlimentos(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredAlimentos = [..._alimentos];
      });
    } else {
      setState(() {
        _filteredAlimentos = [
          ..._alimentos.where((alimento) =>
              alimento.nombre.toLowerCase().contains(query.toLowerCase()))
        ];
      });
    }
    setData();
  }

  Future<void> _formAlimento(String action) async {
    final nombreController = TextEditingController();
    final caloriasController = TextEditingController();
    final proteinaController = TextEditingController();
    final carbohidratoController = TextEditingController();
    final fibraController = TextEditingController();
    final grasaController = TextEditingController();

    if (action == 'update' && alimentoToUpdate != null) {
      nombreController.text = alimentoToUpdate!.nombre;
      caloriasController.text = alimentoToUpdate!.calorias.toString();
      proteinaController.text = alimentoToUpdate!.proteinas.toString();
      carbohidratoController.text = alimentoToUpdate!.carbohidratos.toString();
      grasaController.text = alimentoToUpdate!.grasas.toString();
      fibraController.text = alimentoToUpdate!.fibra.toString();
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
              action == 'add' ? 'Agregar Alimento' : 'Actualizar Alimento'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nombreController,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa el nombre del alimento.';
                    }
                    return null; // Sin errores
                  },
                ),
                TextField(
                  controller: caloriasController,
                  decoration: const InputDecoration(labelText: 'Calorías'),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly // Solo dígitos
                  ],
                ),
                TextField(
                  controller: proteinaController,
                  decoration: const InputDecoration(labelText: 'Proteinas'),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly // Solo dígitos
                  ],
                ),
                TextField(
                  controller: carbohidratoController,
                  decoration: const InputDecoration(labelText: 'Carbohidratos'),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly // Solo dígitos
                  ],
                ),
                TextField(
                  controller: grasaController,
                  decoration: const InputDecoration(labelText: 'Grasas'),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly // Solo dígitos
                  ],
                ),
                TextField(
                  controller: fibraController,
                  decoration: const InputDecoration(labelText: 'Fibra'),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly // Solo dígitos
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(action == 'add' ? 'Agregar' : 'Actualizar'),
              onPressed: () async {
                if (_formKey.currentState?.validate() == true) {
                  final nombre = nombreController.text;
                  final calorias =
                      double.tryParse(caloriasController.text) ?? 0;
                  final proteinas =
                      double.tryParse(proteinaController.text) ?? 0;
                  final carbohidratos =
                      double.tryParse(carbohidratoController.text) ?? 0;
                  final grasas = double.tryParse(grasaController.text) ?? 0;
                  final fibra = double.tryParse(fibraController.text) ?? 0;

                  Alimento alimento = Alimento(
                      id: alimentoToUpdate?.id,
                      nombre: nombre,
                      calorias: calorias,
                      carbohidratos: carbohidratos,
                      proteinas: proteinas,
                      grasas: grasas,
                      fibra: fibra);

                  bool result = false;

                  if (action == 'add') {
                    result = await _foodController.insertAlimento(alimento);
                    if (result) {
                      setState(() {
                        _filteredAlimentos.add(alimento);
                        _alimentos.add(alimento);
                      });
                      setData();
                    }
                  } else {
                    result = await _foodController.updateAlimento(alimento);
                    await _loadAlimentos();
                  }

                  if (mounted) {
                    Navigator.of(context).pop();
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text(
            'Alimentos',
            style: TextStyle(color: Colors.black87),
          ),
          const SizedBox(
            width: 16.0,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Buscar por nombre',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.search, color: Colors.black54),
                ),
                onChanged: (value) {
                  if (value.isEmpty) {
                    setState(() {
                      _filter = "";
                    });
                    _filterAlimentos(_filter);
                  }
                },
                onEditingComplete: () {
                  setState(() {
                    _filter = _searchController.text;
                  });
                  _filterAlimentos(_filter);
                },
              ),
            ),
          ),
        ]),
        backgroundColor: Colors.transparent,
        elevation: 4,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        elevation: 4,
        onPressed: () => _formAlimento('add'),
        child: const Icon(Icons.add),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: _restartAlimentos,
              ),
              const Spacer(),
              const Text('Ordenar por:'),
              const SizedBox(
                width: 8,
              ),
              DropdownButton(
                  value: orderSelectedField,
                  icon: currentOrderOption == 'asc'
                      ? const Icon(Icons.keyboard_double_arrow_up)
                      : const Icon(Icons.keyboard_double_arrow_down),
                  items: _orderFields,
                  onChanged: (value) {
                    setState(() {
                      orderSelectedField = value;
                      sortFoods();
                    });
                  }),
              const Spacer(),
              PopupMenuButton<String>(
                onSelected: (String result) {
                  setState(() {
                    currentOrderOption = result;
                    sortFoods();
                  });
                },
                itemBuilder: (BuildContext context) {
                  return _orderOptions.map((String option) {
                    return PopupMenuItem<String>(
                      value: option,
                      child: Text(option == currentOrderOption
                          ? '* ${option}endente'
                          : '${option}endente'),
                    );
                  }).toList();
                },
              )
            ],
          ),
          const Divider(
            height: 8.0,
          ),
          Expanded(
              child: isLoading
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text('Reiniciando alimentos...'),
                        ],
                      ),
                    )
                  : ListView(
                      children: _items,
                    )
              /* ListView.builder(
                    itemCount: _filteredAlimentos.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text(_filteredAlimentos[index].nombre),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    const Text(
                                      'Calorías',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    Text(
                                        '${_filteredAlimentos[index].calorias} Kcal',
                                        style:
                                            const TextStyle(color: Colors.red)),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text('Proteínas',
                                        style: TextStyle(
                                            color: Colors.blueAccent)),
                                    Text(
                                        '${_filteredAlimentos[index].proteinas}g',
                                        style: const TextStyle(
                                            color: Colors.blueAccent)),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('Carbohidratos',
                                        style: TextStyle(
                                            color: Colors.orange.shade700)),
                                    Text(
                                        '${_filteredAlimentos[index].carbohidratos}g',
                                        style: TextStyle(
                                            color: Colors.orange[700])),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text('Grasas',
                                        style: TextStyle(color: Colors.green)),
                                    Text('${_filteredAlimentos[index].grasas}g',
                                        style: const TextStyle(
                                            color: Colors.green)),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text('Fibra',
                                        style: TextStyle(color: Colors.brown)),
                                    Text('${_filteredAlimentos[index].fibra}g',
                                        style: const TextStyle(
                                            color: Colors.brown)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          if (index <
                              _filteredAlimentos.length -
                                  1) // Evita el separador en el último elemento
                            const Divider(
                              color: Colors.blue,
                            ),
                        ],
                      );
                    },
                  ), */
              ),
        ],
      ),
    );
  }

  void showSnackBar(BuildContext context, String s) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(s),
    ));
  }

  void sortFoods() {
    setState(() {
      switch (orderSelectedField) {
        case 'nombre':
          if (currentOrderOption == _orderOptions[0]) {
            _filteredAlimentos.sort((a, b) => a.nombre.compareTo(b.nombre));
          } else {
            _filteredAlimentos.sort((a, b) => b.nombre.compareTo(a.nombre));
          }
          break;
        case 'proteina':
          if (currentOrderOption == _orderOptions[0]) {
            _filteredAlimentos
                .sort((a, b) => a.proteinas.compareTo(b.proteinas));
          } else {
            _filteredAlimentos
                .sort((a, b) => b.proteinas.compareTo(a.proteinas));
          }
          break;
        case 'carbohidratos':
          if (currentOrderOption == _orderOptions[0]) {
            _filteredAlimentos
                .sort((a, b) => a.carbohidratos.compareTo(b.carbohidratos));
          } else {
            _filteredAlimentos
                .sort((a, b) => b.carbohidratos.compareTo(a.carbohidratos));
          }
          break;
        case 'grasas':
          if (currentOrderOption == _orderOptions[0]) {
            _filteredAlimentos.sort((a, b) => a.grasas.compareTo(b.grasas));
          } else {
            _filteredAlimentos.sort((a, b) => b.grasas.compareTo(a.grasas));
          }
          break;
        case 'fibra':
          if (currentOrderOption == _orderOptions[0]) {
            _filteredAlimentos.sort((a, b) => a.fibra.compareTo(b.fibra));
          } else {
            _filteredAlimentos.sort((a, b) => b.fibra.compareTo(a.fibra));
          }
          break;
        case 'calorias':
          if (currentOrderOption == _orderOptions[0]) {
            _filteredAlimentos.sort((a, b) => a.calorias.compareTo(b.calorias));
          } else {
            _filteredAlimentos.sort((a, b) => b.calorias.compareTo(a.calorias));
          }
          break;
      }
    });
    setData();
  }
}
