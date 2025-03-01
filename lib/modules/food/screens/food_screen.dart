import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_fit_traker/modules/food/infrastructure/food_controller.dart';
import 'package:nutrition_fit_traker/modules/food/models/alimento.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  final FoodController _foodController = FoodController();

  List<Alimento> _alimentos = [];
  List<Alimento> _filteredAlimentos = [];
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String _filter = "";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadAlimentos();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        FocusScope.of(context).requestFocus(_focusNode);
      }
    });
  }

  Future<void> _loadAlimentos() async {
    List<Alimento> alimentos = await _foodController.getAlimentos();
    setState(() {
      _alimentos = alimentos;
      _filteredAlimentos = [..._alimentos];
    });
  }

  Future<void> _updateAlimentos() async {
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
    setState(() {
      isLoading = false;
    });
  }

  void _filterAlimentos(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredAlimentos = _alimentos;
      });
    } else {
      setState(() {
        _filteredAlimentos = [
          ..._alimentos.where((alimento) =>
              alimento.nombre.toLowerCase().contains(query.toLowerCase()))
        ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        elevation: 4,
        onPressed: () {
          showSnackBar(context, 'Función no implementada');
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: _updateAlimentos,
              ),
              Expanded(
                child: CupertinoTextField(
                  suffix: const Icon(Icons.search),
                  focusNode: _focusNode,
                  placeholder: 'Filtrar por nombre',
                  controller: _searchController,
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
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 8.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: CupertinoColors.activeBlue,
                          width: 1), // Línea debajo
                    ),
                  ),
                ),
              ),
            ],
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
                : ListView.builder(
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
                  ),
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
}
