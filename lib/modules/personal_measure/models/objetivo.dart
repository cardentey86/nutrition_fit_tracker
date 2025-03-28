import 'package:easy_localization/easy_localization.dart';

class Objetivo {
  late int id;
  late String name;
  late double value;
  late double proteinas;
  late double carbohidratos;
  late double grasas;

  List<Objetivo> objetivos() {
    List<Objetivo> objetivo = [
      Objetivo()
        ..id = 1
        ..name = 'personalMeasure.objetive.obj1'.tr()
        ..proteinas = 30
        ..carbohidratos = 40
        ..grasas = 30
        ..value = -20, // Reducir el 20 porciento
      Objetivo()
        ..id = 2
        ..name = 'personalMeasure.objetive.obj2'.tr()
        ..proteinas = 25
        ..carbohidratos = 50
        ..grasas = 25
        ..value = 10, // Aumentar el 10 porciento
      Objetivo()
        ..id = 3
        ..name = 'personalMeasure.objetive.obj3'.tr()
        ..proteinas = 25
        ..carbohidratos = 50
        ..grasas = 25
        ..value = 100, // Mantener
    ];

    return objetivo;
  }
}
