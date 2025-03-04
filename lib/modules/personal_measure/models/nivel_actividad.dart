class NivelActividad {
  late int id;
  late String name;
  late double value;

  List<NivelActividad> nivelesActividad() {
    List<NivelActividad> niveles = [
      NivelActividad()
        ..id = 1
        ..name = 'Sedentario'
        ..value = 1.2,
      NivelActividad()
        ..id = 2
        ..name = 'Levemente activo (ejercicios 1-3 dias x semana)'
        ..value = 1.375,
      NivelActividad()
        ..id = 3
        ..name = 'Moderadamente activo (ejercicios 3-5 dias x semana)'
        ..value = 1.55,
      NivelActividad()
        ..id = 4
        ..name = 'Activo (ejercicios 6-7 dias x semana)'
        ..value = 1.725,
      NivelActividad()
        ..id = 5
        ..name = 'Alto Rendimiento'
        ..value = 1.9,
    ];

    return niveles;
  }
}

class Objetivo {
  late int id;
  late String name;
  late double value;

  List<Objetivo> objetivos() {
    List<Objetivo> objetivo = [
      Objetivo()
        ..id = 1
        ..name = 'Perder peso'
        ..value = -20, // Reducir el 20 porciento
      Objetivo()
        ..id = 2
        ..name = 'Ganar Músculo '
        ..value = 10, // Aumentar el 10 porciento
      Objetivo()
        ..id = 3
        ..name = 'Mantener el peso'
        ..value = 100, // Mantener
    ];

    return objetivo;
  }
}
