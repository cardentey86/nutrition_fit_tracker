import 'dart:math';

import 'package:nutrition_fit_traker/modules/personal_measure/infrastructure/personal_measure_controller.dart';
import 'package:nutrition_fit_traker/modules/personal_measure/models/measure_model.dart';
import 'package:nutrition_fit_traker/modules/personal_measure/models/nivel_actividad.dart';
import 'package:nutrition_fit_traker/modules/personal_measure/models/objetivo.dart';

class IndicesController {
  final PersonalMeasureController _personalMeasureController =
      PersonalMeasureController();

  Future<double> imc(PersonalMeasure? measure) async {
    measure ??= await _personalMeasureController.getLast();
    if (measure == null) {
      return 0;
    } else {
      double estaturaMetros = measure.estatura / 100;
      return measure.peso / (estaturaMetros * estaturaMetros);
    }
  }

  Future<int> rmc() async {
    final measure = await _personalMeasureController.getLast();
    if (measure == null) {
      return 0;
    } else {
      return 220 - measure.edad;
    }
  }

  Future<double> porcientoGrasaYMCA() async {
    final measure = await _personalMeasureController.getLast();
    if (measure == null) {
      return 0;
    } else {
      double porcientoGrasa = 0;
      double imc = await this.imc(measure);

      if (measure.sexo == 'Hombre') {
        porcientoGrasa = (0.78 * imc) + (0.23 * measure.edad) - 16.2;
      } else {
        porcientoGrasa = (0.9 * imc) + (0.1 * measure.edad) - 5.4;
      }

      return porcientoGrasa;
    }
  }

  // Se usa en la fuerza aerea de EEUU
  Future<double> porcientoGrasaJacksonPollock() async {
    final measure = await _personalMeasureController.getLast();
    if (measure == null) {
      return 0;
    } else {
      double porcientoGrasa = 0;

      double cinturaCuello = measure.cintura - measure.cuello;
      double logaritmoCinturaCuello = log(cinturaCuello) / ln10;
      double logaritmoEstatura = log(measure.estatura) / ln10;

      if (measure.sexo == 'Hombre') {
        porcientoGrasa = (86.010 * logaritmoCinturaCuello) -
            (70.040 * logaritmoEstatura) +
            36.76;
      } else {
        double cinturaCaderaCuello =
            measure.cintura + measure.cadera - measure.cuello;
        double logaritmoCinturaCaderaCuello = log(cinturaCaderaCuello) / ln10;
        porcientoGrasa = (163.205 * logaritmoCinturaCaderaCuello) -
            (97.684 * logaritmoEstatura) -
            78.387;
      }

      return porcientoGrasa;
    }
  }

  Future<double> tasaMetabolica(PersonalMeasure? measure) async {
    measure ??= await _personalMeasureController.getLast();
    if (measure == null) {
      return 0;
    } else {
      double tasaMetabolica = 0;

      if (measure.sexo == 'Hombre') {
        tasaMetabolica = (10 * measure.peso) +
            (6.25 * measure.estatura) -
            (5 * measure.edad) +
            5;
      } else {
        tasaMetabolica = (6.25 * measure.estatura) - (5 * measure.edad) - 161;
      }

      return tasaMetabolica;
    }
  }

  Future<double> consumoMacronutrientes() async {
    final measure = await _personalMeasureController.getLast();
    if (measure == null) {
      return 0;
    }
    double consumoMacro = 0;
    double tmb = await tasaMetabolica(measure);
    NivelActividad nivelActividad = NivelActividad()
        .nivelesActividad()
        .firstWhere((element) => element.id == measure.nivelActividad);

    double consumoCalorico = tmb * nivelActividad.value;

    Objetivo objetivo =
        Objetivo().objetivos().firstWhere((obj) => obj.id == measure.objetivo);

    consumoMacro = consumoCalorico + (consumoCalorico * objetivo.value / 100);

    return consumoMacro;
  }
}
