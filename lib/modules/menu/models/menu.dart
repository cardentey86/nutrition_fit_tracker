import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_fit_traker/modules/menu/models/menu_plato.dart';
import 'package:sqflite/sqflite.dart';

class Menu {
  int? id;
  String nombre;
  List<MenuPlato> platos;

  Menu({
    this.id,
    required this.nombre,
    required this.platos,
  });

  static Future<Menu> fromMap(
      Map<String, dynamic> map, Database db, String code) async {
    int menuId = map['Id'];

    String menuNombre = map['Nombre'] ?? 'Nombre no disponible';

    List<Map<String, dynamic>> platosData = await db.rawQuery('''
      SELECT *  
      FROM MenuPlato 
      WHERE IdMenu = ?  
    ''', [menuId]);

    List<Future<MenuPlato>> platosFutures = platosData.map((platoMap) {
      return MenuPlato.fromMap(platoMap, db, code);
    }).toList();

    List<MenuPlato> platos = await Future.wait(platosFutures);

    return Menu(
      id: menuId,
      nombre: menuNombre,
      platos: platos,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': id,
      'Nombre': nombre,
    };
  }

  static List<String> menuNames(BuildContext context) {
    return [
      'menuFood.dialog.breakfast'.tr(),
      'menuFood.dialog.lunch'.tr(),
      'menuFood.dialog.dinner'.tr(),
      'menuFood.dialog.snack'.tr(),
    ];
  }
}
