import 'package:nutrition_fit_traker/data/database_helper.dart';
import 'package:nutrition_fit_traker/modules/personal_measure/models/measure_model.dart';
import 'package:sqflite/sqflite.dart';

class PersonalMeasureController {
  static final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<bool> insert(PersonalMeasure personalMeasure) async {
    final db = await _dbHelper.database;
    int result = await db.insert(
      'MedidasPersonales',
      personalMeasure.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return result > 0;
  }

  Future<bool> update(PersonalMeasure personalMeasure) async {
    final db = await _dbHelper.database;
    int result = await db.update(
      'MedidasPersonales',
      personalMeasure.toMap(),
      where: 'id = ${personalMeasure.id}',
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return result > 0;
  }

  Future<PersonalMeasure?> getLast() async {
    final db = await _dbHelper.database;

    final List<Map<String, dynamic>> result = await db.query(
      'MedidasPersonales',
      orderBy: 'Fecha DESC',
      limit: 1,
    );

    if (result.isNotEmpty) {
      return PersonalMeasure.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<List<PersonalMeasure>> getAll() async {
    final db = await _dbHelper.database;

    final List<Map<String, dynamic>> result = await db.query(
      'MedidasPersonales',
      orderBy: 'Fecha DESC',
    );

    if (result.isNotEmpty) {
      return List.generate(result.length, (i) {
        return PersonalMeasure(
          id: result[i]['Id'],
          fecha: result[i]['Fecha'],
          edad: result[i]['Edad'],
          sexo: result[i]['Sexo'],
          estatura: result[i]['Estatura'],
          objetivo: result[i]['Objetivo'],
          nivelActividad: result[i]['NivelActividad'],
          peso: result[i]['Peso'],
          cintura: result[i]['Cintura'],
          cadera: result[i]['Cadera'],
          cuello: result[i]['Cuello'],
          muneca: result[i]['Muneca'],
          tobillo: result[i]['Tobillo'],
          pecho: result[i]['Pecho'],
          biceps: result[i]['Biceps'],
          antebrazo: result[i]['Antebrazo'],
          muslo: result[i]['Muslo'],
          gemelos: result[i]['Gemelos'],
        );
      });
    } else {
      return [];
    }
  }

  Future<bool> any() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT COUNT(*) AS count FROM MedidasPersonales');
    int count = Sqflite.firstIntValue(result)!;
    return count > 0;
  }

  /* Future<bool> eliminarAlimento(int id) async {
    final db = await _dbHelper.database;
    int result = await db.delete('alimentos', where: 'id = $id');
    return result > 0;
  }
 */
}
