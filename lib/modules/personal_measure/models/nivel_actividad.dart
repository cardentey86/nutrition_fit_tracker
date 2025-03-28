import 'package:easy_localization/easy_localization.dart';

class NivelActividad {
  late int id;
  late String name;
  late double value;

  List<NivelActividad> nivelesActividad() {
    List<NivelActividad> niveles = [
      NivelActividad()
        ..id = 1
        ..name = 'personalMeasure.activity.activity1'.tr()
        ..value = 1.2,
      NivelActividad()
        ..id = 2
        ..name = 'personalMeasure.activity.activity2'.tr()
        ..value = 1.375,
      NivelActividad()
        ..id = 3
        ..name = 'personalMeasure.activity.activity3'.tr()
        ..value = 1.55,
      NivelActividad()
        ..id = 4
        ..name = 'personalMeasure.activity.activity4'.tr()
        ..value = 1.725,
      NivelActividad()
        ..id = 5
        ..name = 'personalMeasure.activity.activity5'.tr()
        ..value = 1.9,
    ];

    return niveles;
  }
}
