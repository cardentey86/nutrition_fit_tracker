import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:nutrition_fit_traker/data/database_helper.dart';
import 'package:nutrition_fit_traker/modules/food/models/alimento.dart';
import 'package:sqflite/sqflite.dart';

class FoodController {
  static final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<bool> insertAlimento(Alimento alimento) async {
    final db = await _dbHelper.database;
    int result = await db.insert(
      'alimentos',
      alimento.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return result > 0;
  }

  Future<List<Alimento>> getAlimentos() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps =
        await db.query('alimentos', orderBy: 'Alimento');

    return List.generate(maps.length, (i) {
      return Alimento(
        id: maps[i]['id'],
        nombre: maps[i]['Alimento'],
        calorias: (maps[i]['Calorias'] is int)
            ? (maps[i]['Calorias'] as int).toDouble()
            : (maps[i]['Calorias'] as double),
        carbohidratos: (maps[i]['Carbohidratos'] is int)
            ? (maps[i]['Carbohidratos'] as int).toDouble()
            : (maps[i]['Carbohidratos'] as double),
        proteinas: (maps[i]['Proteinas'] is int)
            ? (maps[i]['Proteinas'] as int).toDouble()
            : (maps[i]['Proteinas'] as double),
        grasas: (maps[i]['Grasas'] is int)
            ? (maps[i]['Grasas'] as int).toDouble()
            : (maps[i]['Grasas'] as double),
        fibra: (maps[i]['Fibra'] is int)
            ? (maps[i]['Fibra'] as int).toDouble()
            : (maps[i]['Fibra'] as double),
      );
    });
  }

  Future<bool> any() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT COUNT(*) AS count FROM alimentos');
    int count = Sqflite.firstIntValue(result)!;
    return count > 0;
  }

  Future<void> clearAlimentos() async {
    final db = await _dbHelper.database;
    await db.delete('alimentos');
  }

  Future<void> migrarAlimentos() async {
    String jsonString =
        await rootBundle.loadString('assets/data/alimentosJson.json');
    List<dynamic> jsonList = json.decode(jsonString);

    for (var item in jsonList) {
      Alimento alimento = Alimento.fromJson(item);
      await insertAlimento(alimento);
    }
  }

  Future<bool> eliminarAlimento(int id) async {
    final db = await _dbHelper.database;
    int result = await db.delete('alimentos', where: 'id = $id');
    return result > 0;
  }

  Future<void> reiniciarAlimentos() async {
    await clearAlimentos();
    String jsonString =
        await rootBundle.loadString('assets/data/alimentosJson.json');
    List<dynamic> jsonList = json.decode(jsonString);

    for (var item in jsonList) {
      Alimento alimento = Alimento.fromJson(item);
      await insertAlimento(alimento);
    }
  }
}
