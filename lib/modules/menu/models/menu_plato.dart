import 'package:nutrition_fit_traker/modules/food/models/food_model.dart';
import 'package:nutrition_fit_traker/modules/traduccion/traduccion_controller.dart';
import 'package:nutrition_fit_traker/modules/traduccion/traduccion_model.dart';
import 'package:sqflite/sqflite.dart';

class MenuPlato {
  int? id;
  int idMenu;
  int idAlimento;
  String fecha;
  double cantidad;
  Alimento? alimento;

  MenuPlato(
      {this.id,
      required this.idMenu,
      required this.idAlimento,
      required this.fecha,
      required this.cantidad,
      this.alimento});

  static Future<MenuPlato> fromMap(
      Map<String, dynamic> map, Database db, String code) async {
    List<Map<String, dynamic>> alimentoData = await db.query('Alimento',
        where: 'Id = ?', whereArgs: [map['IdAlimento']], limit: 1);

    AlimentoTraduccion? alimentoTraduccion =
        await TraduccionController().getTraduccion(map['IdAlimento'], code);

    Alimento alimento =
        Alimento.fromMap(alimentoData.first, alimentoTraduccion);

    return MenuPlato(
        id: map['Id'],
        idMenu: map['IdMenu'],
        idAlimento: map['IdAlimento'],
        fecha: map['Fecha'],
        cantidad: map['Cantidad'],
        alimento: alimento);
  }

  static Future<MenuPlato> fromMapLite(Map<String, dynamic> map) async {
    return MenuPlato(
        id: map['Id'],
        idMenu: map['IdMenu'],
        idAlimento: map['IdAlimento'],
        fecha: map['Fecha'],
        cantidad: map['Cantidad']);
  }

  Map<String, dynamic> toMapForInsert(
      int idMenu, int idAlimento, String fecha, double cantidad) {
    return {
      'IdMenu': idMenu,
      'IdAlimento': idAlimento,
      'Fecha': fecha,
      'Cantidad': cantidad,
    };
  }

  Map<String, dynamic> toMapForUpdate(int id, double cantidad) {
    return {
      'Id': id,
      'Cantidad': cantidad,
    };
  }
}
