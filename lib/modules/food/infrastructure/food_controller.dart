import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:nutrition_fit_traker/data/database_helper.dart';
import 'package:nutrition_fit_traker/modules/traduccion/traduccion_model.dart';
import 'package:nutrition_fit_traker/modules/traduccion/traduccion_controller.dart';
import 'package:nutrition_fit_traker/modules/food/models/food_model.dart';
import 'package:sqflite/sqflite.dart';

class FoodController {
  static final DatabaseHelper _dbHelper = DatabaseHelper();
  static final TraduccionController _traduccionController =
      TraduccionController();

  Future<bool> insertAlimento(Alimento alimento, String code) async {
    final db = await _dbHelper.database;
    int result = await db.insert(
      'Alimento',
      alimento.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    switch (code) {
      case 'es':
        await _traduccionController.insertTraduccion(AlimentoTraduccion(
          idAlimento: result,
          code: 'es',
          nombreAlimento: alimento.nombre,
        ));
        break;
      case 'en':
        await _traduccionController.insertTraduccion(AlimentoTraduccion(
          idAlimento: result,
          code: 'en',
          nombreAlimento: alimento.nombre,
        ));
    }

    return result > 0;
  }

  Future<bool> updateAlimento(Alimento alimento, String code) async {
    final db = await _dbHelper.database;
    int result = await db.update(
      'Alimento',
      alimento.toMap(),
      where: 'id = ${alimento.id}',
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    await _traduccionController.updateTraduccion(AlimentoTraduccion(
      idAlimento: alimento.id!,
      code: code,
      nombreAlimento: alimento.nombre,
    ));

    return result > 0;
  }

  Future<Alimento> getAlimento(int id, String code) async {
    final db = await _dbHelper.database;
    final alimento =
        await db.query('Alimento', where: 'Id = ?', whereArgs: [id], limit: 1);

    final traduccion = await _traduccionController.getTraduccion(id, code);

    return Alimento.fromMap(alimento.first, traduccion);
  }

  Future<List<Alimento>> getAlimentos(String code) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps =
        await db.query('Alimento', orderBy: 'Nombre');

    final traducciones = await db
        .query('AlimentoTraduccion', where: 'Code = ?', whereArgs: [code]);

    return List.generate(maps.length, (i) {
      AlimentoTraduccion traduccion = traducciones
              .firstWhere((element) => element['IdAlimento'] == maps[i]['Id'])
          as AlimentoTraduccion;

      return Alimento(
        id: maps[i]['Id'],
        nombre: traduccion.nombreAlimento,
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
        await db.rawQuery('SELECT COUNT(*) AS count FROM Alimento');
    int count = Sqflite.firstIntValue(result)!;
    return count > 0;
  }

  Future<void> clearAlimentos() async {
    final db = await _dbHelper.database;
    await db.delete('Alimento');
  }

  /*Future<void> migrarAlimentos() async {
    String jsonString =
        await rootBundle.loadString('assets/data/alimentosJson.json');
    List<dynamic> jsonList = json.decode(jsonString);

    for (var item in jsonList) {
      Alimento alimento = Alimento.fromJson(item);
      await insertAlimento(alimento);
    }
  }*/

  Future<bool> eliminarAlimento(int id) async {
    final db = await _dbHelper.database;
    await _traduccionController.eliminarTraduccion(id);
    int result = await db.delete('Alimento', where: 'Id = $id');
    return result > 0;
  }

  Future<void> reiniciarAlimentos() async {
    final db = await _dbHelper.database;
    await _traduccionController.clearTraducciones();
    await clearAlimentos();
    String jsonStringEs =
        await rootBundle.loadString('assets/data/alimentosJsonEs.json');
    String jsonStringEn =
        await rootBundle.loadString('assets/data/alimentosJsonEn.json');

    List<dynamic> jsonListEs = json.decode(jsonStringEs);
    List<dynamic> jsonListEn = json.decode(jsonStringEn);

    for (int i = 0; i < jsonListEs.length; i++) {
      Alimento alimentoEs = Alimento.fromJson(jsonListEs[i]);
      Alimento alimentoEn = Alimento.fromJson(jsonListEn[i]);

      int result = await db.insert(
        'Alimento',
        alimentoEs.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      _traduccionController.insertTraduccion(AlimentoTraduccion(
        idAlimento: alimentoEs.id!,
        code: 'es',
        nombreAlimento: alimentoEs.nombre,
      ));
      _traduccionController.insertTraduccion(AlimentoTraduccion(
        idAlimento: alimentoEn.id!,
        code: 'en',
        nombreAlimento: alimentoEn.nombre,
      ));
    }
  }

  double CalcularConsumoAlimento(double cantidadGramos, double valorMacro) {
    return double.parse((cantidadGramos * valorMacro / 100).toStringAsFixed(1));
  }
}
