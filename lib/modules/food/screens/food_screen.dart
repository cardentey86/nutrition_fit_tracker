import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nutrition_fit_traker/data/database_helper.dart';
import 'package:nutrition_fit_traker/modules/food/models/alimento.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  List<Alimento> _alimentos = [];
  List<Alimento> _filteredAlimentos = [];

  String _filter = "";

  @override
  void initState() {
    super.initState();
    _loadAlimentos();
  }

  Future<void> _loadAlimentos() async {
    List<Alimento> alimentos = await _dbHelper.getAlimentos();
    setState(() {
      _alimentos = alimentos;
      _filteredAlimentos = _alimentos;
    });
  }

  Future<void> _updateAlimentos() async {
    // Mostrar un cuadro de diálogo de confirmación
    if (await _dbHelper.any()) {
      final bool? respuesta = await showDialog<bool>(
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
                  Navigator.of(context)
                      .pop(true); // Cerrar el diálogo y devolver verdadero
                },
                child: const Text('Confirmar'),
              ),
            ],
          );
        },
      );

      if (respuesta == true) {
        _reiniciarAlimentos();
      }
    } else {
      _reiniciarAlimentos();
    }
  }

  void _reiniciarAlimentos() async {
    await _dbHelper.clearAlimentos();
    // Carga el JSON
    String jsonString =
        await rootBundle.loadString('assets/data/alimentosJson.json');
    List<dynamic> jsonList = json.decode(jsonString);

    for (var item in jsonList) {
      Alimento alimento = Alimento.fromJson(item);
      await _dbHelper.insertAlimento(alimento);
    }
    await _loadAlimentos();
  }

  void _filterAlimentos(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredAlimentos = _alimentos;
      });
    } else {
      setState(() {
        _filteredAlimentos = _alimentos
            .where((alimento) =>
                alimento.nombre.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                placeholder: 'Filtrar por nombre',
                onChanged: (value) {
                  _filterAlimentos(value);
                },
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
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
          child: ListView.builder(
            itemCount: _filteredAlimentos.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_alimentos[index].nombre),
                subtitle: Text('${_alimentos[index].calorias} calorías'),
              );
            },
          ),
        ),
      ],
    );
  }
}
