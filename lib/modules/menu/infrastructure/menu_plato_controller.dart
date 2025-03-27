import 'package:nutrition_fit_traker/data/database_helper.dart';
import 'package:nutrition_fit_traker/modules/menu/models/menu.dart';
import 'package:nutrition_fit_traker/modules/menu/models/menu_plato.dart';
import 'package:sqflite/sqflite.dart';

class MenuPlatoController {
  static final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<bool> insertMenuWithPlato(Menu menu) async {
    final db = await _dbHelper.database;

    int idMenu =
        await insertMenu(Menu(nombre: menu.nombre, platos: List.empty()));

    for (var plato in menu.platos) {
      await db.insert(
          'MenuPlato',
          plato.toMapForInsert(
              idMenu, plato.idAlimento, plato.fecha, plato.cantidad));
    }
    return true;
  }

  Future<int> insertMenu(Menu menu) async {
    final db = await _dbHelper.database;
    int id = await db.insert('Menu', menu.toMap());
    return id;
  }

  Future<int> insertMenuPlato(MenuPlato menuPlato) async {
    final db = await _dbHelper.database;
    int id = await db.insert(
        'MenuPlato',
        menuPlato.toMapForInsert(menuPlato.idMenu, menuPlato.idAlimento,
            menuPlato.fecha, menuPlato.cantidad));
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
      menuPlato.toMapForUpdate(menuPlato.id!, menuPlato.cantidad),
      where: 'id = ${menuPlato.id}',
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return result > 0;
  }

  Future<List<Menu>> getAllMenu(String code) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps =
        await db.query('Menu', orderBy: 'Id');

    List<Menu> menuList = [];
    for (var map in maps) {
      Menu menu = await Menu.fromMap(map, db, code);
      menuList.add(menu);
    }

    return menuList;
  }

  Future<List<MenuPlato>> getAllMenuPlato() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps =
        await db.query('MenuPlato', orderBy: 'Id');

    List<MenuPlato> menuList = [];
    for (var map in maps) {
      MenuPlato menuPlato = await MenuPlato.fromMapLite(map);
      menuList.add(menuPlato);
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

  Future<Menu?> getById(int id, String code) async {
    final db = await _dbHelper.database;
    List<Map<String, dynamic>> maps = await db.query(
      'Menu',
      where: 'Id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return await Menu.fromMap(maps.first, db, code);
    } else {
      return null;
    }
  }

  Future<MenuPlato?> getMenuPlatoById(int id, String code) async {
    final db = await _dbHelper.database;
    List<Map<String, dynamic>> maps = await db.query(
      'MenuPlato',
      where: 'Id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return await MenuPlato.fromMap(maps.first, db, code);
    } else {
      return null;
    }
  }

  Future<Menu?> getByName(String name, String code) async {
    final db = await _dbHelper.database;
    List<Map<String, dynamic>> maps = await db.query(
      'Menu',
      where: 'Nombre = ?',
      whereArgs: [name],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return await Menu.fromMap(maps.first, db, code);
    } else {
      return null;
    }
  }

  Future<bool> eliminarMenuPlato(int id) async {
    final db = await _dbHelper.database;
    int result = await db.delete('MenuPlato', where: 'Id = $id');
    return result > 0;
  }

  Future<bool> anyMenuPlato() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT COUNT(*) AS count FROM MenuPlato');
    int count = Sqflite.firstIntValue(result)!;
    return count > 0;
  }

  Future<bool> eliminarMenu(int menuId) async {
    final db = await _dbHelper.database;

    await db.delete(
      'MenuPlato',
      where: 'IdMenu = ?',
      whereArgs: [menuId],
    );

    int result = await db.delete(
      'Menu',
      where: 'Id = ?',
      whereArgs: [menuId],
    );

    return result > 0;
  }
}
