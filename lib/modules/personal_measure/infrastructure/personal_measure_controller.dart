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
