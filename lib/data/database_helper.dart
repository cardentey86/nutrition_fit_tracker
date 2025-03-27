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
      version: 2, // ⬅️ incrementa la versión aquí
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE Alimento(Id INTEGER PRIMARY KEY, Nombre TEXT, Calorias INTEGER, Carbohidratos REAL, Proteinas REAL, Grasas REAL, Fibra REAL)',
        );
        await db.execute(
          'CREATE TABLE MedidasPersonales(Id INTEGER PRIMARY KEY, Fecha TEXT, Edad INTEGER, Estatura REAL, Peso REAL, Sexo TEXT, Pecho REAL, Cintura REAL, Cadera REAL, Muslo REAL, Gemelos REAL, Biceps REAL, Antebrazo REAL, Muneca REAL, Cuello REAL, Tobillo REAL, Objetivo INTEGER, NivelActividad INTEGER)',
        );
        await db.execute(
          'CREATE TABLE Menu(Id INTEGER PRIMARY KEY, Nombre TEXT)',
        );
        await db.execute(
          'CREATE TABLE MenuPlato(Id INTEGER PRIMARY KEY, IdMenu INTEGER, IdAlimento INTEGER, Fecha TEXT, Cantidad REAL, FOREIGN KEY(IdMenu) REFERENCES Menu(Id), FOREIGN KEY(IdAlimento) REFERENCES Alimento(Id))',
        );
        await db.execute(
          'CREATE TABLE AlimentoTraduccion(Id INTEGER PRIMARY KEY AUTOINCREMENT, IdAlimento INTEGER, Code TEXT, NombreAlimento TEXT, FOREIGN KEY(IdAlimento) REFERENCES Alimento(Id))',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute(
            'CREATE TABLE AlimentoTraduccion(Id INTEGER PRIMARY KEY AUTOINCREMENT, IdAlimento INTEGER, Code TEXT, NombreAlimento TEXT, FOREIGN KEY(IdAlimento) REFERENCES Alimento(Id))',
          );
        }
      },
    );
  }
}
