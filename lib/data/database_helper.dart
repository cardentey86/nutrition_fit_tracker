import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'nft.db');
    return await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE alimentos(id INTEGER PRIMARY KEY, Alimento TEXT, Calorias INTEGER, Carbohidratos REAL, Proteinas REAL, Grasas REAL, Fibra REAL)',
        );
      },
      version: 1,
    );
  }

  /* Future<void> insertAlimento(Alimento alimento) async {
    final db = await database;
    await db.insert(
      'alimentos',
      alimento.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Alimento>> getAlimentos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('alimentos', orderBy: 'Alimento');

    return List.generate(maps.length, (i) {
      return Alimento(
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
    final db = await database;
    final List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT COUNT(*) AS count FROM alimentos');
    int count = Sqflite.firstIntValue(result)!;
    return count > 0;
  }

  Future<void> clearAlimentos() async {
    final db = await database;
    await db.delete('alimentos');
  } */
}
