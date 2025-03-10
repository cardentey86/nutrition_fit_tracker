import 'package:nutrition_fit_traker/data/database_helper.dart';
import 'package:nutrition_fit_traker/modules/menu/models/menu.dart';
import 'package:nutrition_fit_traker/modules/menu/models/menu_plato.dart';
import 'package:sqflite/sqflite.dart';

class MenuController {
  static final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<bool> insertMenuPlato(Menu menu) async {
    final db = await _dbHelper.database;

    int idMenu =
        await insertMenu(Menu(nombre: menu.nombre, platos: List.empty()));

    for (var plato in menu.platos) {
      await db.insert('MenuPlato',
          plato.toMapForInsert(idMenu, plato.fecha, plato.cantidad));
    }
    return true;
  }

  Future<int> insertMenu(Menu menu) async {
    final db = await _dbHelper.database;
    int id = await db.insert('Menu', menu.toMap());
    return id;
  }

  Future<bool> updateMenu(Menu menu) async {
    final db = await _dbHelper.database;
    int result = await db.update(
      'Menu',
      menu.toMap(),
      where: 'id = ${menu.id}',
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return result > 0;
  }

  Future<bool> updateMenuPlato(MenuPlato menuPlato) async {
    final db = await _dbHelper.database;
    int result = await db.update(
      'MenuPlato',
      menuPlato.toMapForInsert(
          menuPlato.idMenu, menuPlato.fecha, menuPlato.cantidad),
      where: 'id = ${menuPlato.id}',
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return result > 0;
  }

  Future<List<Menu>> getAll() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps =
        await db.query('Menu', orderBy: 'Nombre');

    List<Menu> menuList = [];
    for (var map in maps) {
      Menu menu = await Menu.fromMap(map, db);
      menuList.add(menu);
    }

    return menuList;
  }

  Future<bool> any() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT COUNT(*) AS count FROM Menu');
    int count = Sqflite.firstIntValue(result)!;
    return count > 0;
  }

  Future<Menu?> getById(int id) async {
    final db = await _dbHelper.database;
    List<Map<String, dynamic>> maps = await db.query(
      'Menu',
      where: 'Id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return await Menu.fromMap(maps.first, db);
    } else {
      return null; // O lanza una excepción, dependiendo de tu lógica
    }
  }

  Future<bool> eliminarMenuPlato(int id) async {
    final db = await _dbHelper.database;
    int result = await db.delete('MenuPlato', where: 'Id = $id');
    return result > 0;
  }

  Future<void> eliminarMenu(int menuId) async {
    final db = await _dbHelper.database;

    await db.delete(
      'MenuPlato',
      where: 'IdMenu = ?',
      whereArgs: [menuId],
    );

    await db.delete(
      'Menu',
      where: 'Id = ?',
      whereArgs: [menuId],
    );
  }
}
