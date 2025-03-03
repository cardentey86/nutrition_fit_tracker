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
        // Crear tabla de alimentos
        db.execute(
          'CREATE TABLE alimentos(id INTEGER PRIMARY KEY, Alimento TEXT, Calorias INTEGER, Carbohidratos REAL, Proteinas REAL, Grasas REAL, Fibra REAL)',
        );

        // Crear tabla de medidas personales
        db.execute(
          'CREATE TABLE MedidasPersonales(Id INTEGER PRIMARY KEY, Fecha TEXT, Edad Integer, Altura REAL, Peso REAL, Sexo TEXT, Pecho REAL, Cintura REAL, Cadera REAL, Muslo REAL, Pantorrilla REAL, Biceps REAL, Antebrazo REAL, Muneca REAL, Cuello REAL, Tobillo REAL)',
        );

        // Crear tabla de menús
        db.execute(
          'CREATE TABLE Menu(Id INTEGER PRIMARY KEY, Nombre TEXT)',
        );

        // Crear tabla de platos en menús
        db.execute(
          'CREATE TABLE MenuPlato(Id INTEGER PRIMARY KEY, IdMenu INTEGER, IdAlimento INTEGER, Fecha TEXT, Tipo TEXT, FOREIGN KEY(IdMenu) REFERENCES Menu(Id), FOREIGN KEY(IdAlimento) REFERENCES alimentos(id))',
        );
      },
      /* onUpgrade: (db, oldVersion, newVersion) {
        if (oldVersion < newVersion) {
          // Cambiar la estructura si estás actualizando a la versión nueva
          db.execute(
              'ALTER TABLE MedidasPersonales ADD COLUMN Edad INTEGER, ADD COLUMN Altura REAL, ADD COLUMN Peso REAL, ADD COLUMN Sexo TEXT');

          db.execute('ALTER TABLE MenuPlato ADD COLUMN Nombre TEXT');
        }
      }, */
      version: 1, // Incrementa la versión aquí   */
    );
  }
}
