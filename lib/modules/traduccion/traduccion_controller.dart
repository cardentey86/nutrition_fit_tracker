import 'package:nutrition_fit_traker/data/database_helper.dart';
import 'package:nutrition_fit_traker/modules/traduccion/traduccion_model.dart';
import 'package:sqflite/sqflite.dart';

class TraduccionController {
  static final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<bool> insertTraduccion(AlimentoTraduccion alimentoTraduccion) async {
    final db = await _dbHelper.database;
    int result = await db.insert(
      'AlimentoTraduccion',
      alimentoTraduccion.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return result > 0;
  }

  Future<bool> updateTraduccion(AlimentoTraduccion alimento) async {
    final db = await _dbHelper.database;
    int result = await db.update(
      'AlimentoTraduccion',
      alimento.toMap(),
      where: 'id = ${alimento.id} and code = ${alimento.code}',
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return result > 0;
  }

  Future<bool> eliminarTraduccion(int idAlimento) async {
    final db = await _dbHelper.database;

    final traducciones =
        await db.query('AlimentoTraduccion', where: 'IdAlimento = $idAlimento');

    for (var element in traducciones) {
      final alimentoTraduccion = AlimentoTraduccion.fromMap(element);

      await db.delete('AlimentoTraduccion',
          where: 'IdAlimento = ${alimentoTraduccion.idAlimento}');
    }
    return true;
  }

  Future<void> clearTraducciones() async {
    final db = await _dbHelper.database;
    await db.delete('AlimentoTraduccion');
  }

  Future<AlimentoTraduccion> getTraduccion(int idAlimento, String code) async {
    final db = await _dbHelper.database;
    final traduccion = await db.query('AlimentoTraduccion',
        where: 'IdAlimento = $idAlimento and code = $code');

    return AlimentoTraduccion.fromMap(traduccion.first);
  }
}
