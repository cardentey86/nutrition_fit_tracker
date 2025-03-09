import 'package:nutrition_fit_traker/modules/food/models/food_model.dart';
import 'package:nutrition_fit_traker/modules/menu/models/menu.dart';
import 'package:sqflite/sqflite.dart';

class MenuPlato {
  int? id;
  int idMenu;
  int idAlimento;
  String fecha;
  double cantidad;
  Menu? menu;
  Alimento? alimento;

  MenuPlato(
      {this.id,
      required this.idMenu,
      required this.idAlimento,
      required this.fecha,
      required this.cantidad,
      this.menu,
      this.alimento});

  static Future<MenuPlato> fromMap(
      Map<String, dynamic> map, Database db) async {
    List<Map<String, dynamic>> alimentoData = await db.query(
      'Alimento',
      where: 'Id = ?',
      whereArgs: [map['IdAlimento']],
    );
    Alimento alimento = Alimento.fromMap(alimentoData.first);

    List<Map<String, dynamic>> menuData = await db.query(
      'Menu',
      where: 'Id = ?',
      whereArgs: [map['IdMenu']],
    );
    Menu menu = await Menu.fromMap(menuData.first, db);

    return MenuPlato(
        id: map['Id'],
        idMenu: map['IdMenu'],
        idAlimento: map['IdAlimento'],
        fecha: map['Fecha'],
        cantidad: map['Cantidad'],
        alimento: alimento,
        menu: menu);
  }

  Map<String, dynamic> toMapForInsert(
      int idMenu, String fecha, double cantidad) {
    return {
      'IdMenu': idMenu,
      'IdAlimento': idAlimento,
      'Fecha': fecha,
      'Cantidad': cantidad,
    };
  }
}
