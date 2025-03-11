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

  static Future<Menu> fromMap(Map<String, dynamic> map, Database db) async {
    int menuId = map['Id'];

    List<Map<String, dynamic>> platosData = await db.rawQuery('''
      SELECT mp.*, a.Nombre AS AlimentoNombre, a.Calorias, a.Carbohidratos, a.Proteinas, a.Grasas, a.Fibra  
      FROM MenuPlato mp  
      INNER JOIN Alimento a ON mp.IdAlimento = a.Id  
      WHERE mp.IdMenu = ?  
    ''', [menuId]);

    List<MenuPlato> platos = platosData
        .map((platoMap) => MenuPlato.fromMap(platoMap, db))
        .cast<MenuPlato>()
        .toList();

    return Menu(
      id: menuId,
      nombre: map['Nombre'],
      platos: platos,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': id,
      'Nombre': nombre,
    };
  }

  static List<String> menuNames() {
    return [
      'Desayuno',
      'Almuerzo',
      'Cena',
      'Merienda Mañana',
      'Merienda Tarde',
      'Merienda Noche'
    ];
  }
}
