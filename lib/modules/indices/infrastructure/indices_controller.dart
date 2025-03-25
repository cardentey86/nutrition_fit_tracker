import 'dart:math';
import 'package:nutrition_fit_traker/modules/indices/models/consumo_macro.dart';
import 'package:nutrition_fit_traker/modules/indices/models/medidas_ideal_mujer.dart';
import 'package:nutrition_fit_traker/modules/indices/models/prediction_model.dart';
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
      return double.parse((measure.peso / (estaturaMetros * estaturaMetros))
          .toStringAsFixed(2));
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
  Future<double> porcientoGrasaJacksonPollock(PersonalMeasure? measure) async {
    measure ??= await _personalMeasureController.getLast();
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

      return double.parse(porcientoGrasa.toStringAsFixed(2));
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

  Future<ConsumoMacro> consumoMacroNutrientesDesglosado() async {
    final measure = await _personalMeasureController.getLast();
    if (measure == null) {
      return ConsumoMacro(0, 0, 0, 0);
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

    double calorias = consumoMacro;
    double proteinas = (consumoMacro * (objetivo.proteinas / 100)) / 4;
    double carbohidratos = (consumoMacro * (objetivo.carbohidratos / 100)) / 4;
    double grasas = (consumoMacro * (objetivo.grasas / 100)) / 9;

    return ConsumoMacro(calorias, carbohidratos, proteinas, grasas);
  }

  Future<PredictionModel?> prediccionGananciaMuscular(
      double? porcientoGrasa) async {
    PersonalMeasure? personalMeasure =
        await _personalMeasureController.getLast();
    PredictionModel predictionModel =
        PredictionModel(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

    if (personalMeasure == null) {
      return null;
    }

    bool medidasPersonales = false;

    if (porcientoGrasa == null) {
      porcientoGrasa = await porcientoGrasaJacksonPollock(null);
      medidasPersonales = true;
    }

    if (medidasPersonales) {
      predictionModel.pecho = convertCmToPlg(personalMeasure.pecho);
      predictionModel.antebrazo = convertCmToPlg(personalMeasure.antebrazo);
      predictionModel.biceps = convertCmToPlg(personalMeasure.biceps);
      predictionModel.cuello = convertCmToPlg(personalMeasure.cuello);
      predictionModel.muslo = convertCmToPlg(personalMeasure.muslo);
      predictionModel.pantorrilla = convertCmToPlg(personalMeasure.gemelos);
      predictionModel.pesoTotal = personalMeasure.peso;
      predictionModel.porcientoGrasa = porcientoGrasa;
      predictionModel.pesoGrasa = await pesoGrasa();
      predictionModel.pesoMagro = await pesoMagro();
    } else {
      double estaturaPulgda = convertCmToPlg(personalMeasure.estatura);
      double munecaPulagada = convertCmToPlg(personalMeasure.muneca);
      double tobilloPulgada = convertCmToPlg(personalMeasure.tobillo);

      double humbralHuesoPequenoMuneca = 0.1045 * estaturaPulgda;
      double humbralHuesoPequenoTobillo = 0.1268 * estaturaPulgda;

      double personalMunecaPulgada = convertCmToPlg(personalMeasure.muneca);
      double personalTobilloPulgada = convertCmToPlg(personalMeasure.tobillo);

      bool ganadorDificilMuneca =
          personalMunecaPulgada < humbralHuesoPequenoMuneca;
      bool ganadorDificilTobillo =
          personalTobilloPulgada < humbralHuesoPequenoTobillo;
      bool ganadorDificil = ganadorDificilMuneca && ganadorDificilTobillo;

      if (ganadorDificil) {
        predictionModel.pesoMagro = estaturaPulgda *
            (munecaPulagada / 7.6364 + tobilloPulgada / 6.2918) *
            (porcientoGrasa / 450 + 1);
      } else if (!ganadorDificilMuneca || !ganadorDificilTobillo) {
        predictionModel.pesoMagro = estaturaPulgda *
            (munecaPulagada / 7.2546 + tobilloPulgada / 5.9772) *
            (porcientoGrasa / 450 + 1);
      }

      if (ganadorDificilMuneca) {
        predictionModel.pecho =
            6.3138 * munecaPulagada * (porcientoGrasa / 340 + 1);
        predictionModel.biceps =
            2.3008 * munecaPulagada * (porcientoGrasa / 265 + 1);
        predictionModel.antebrazo =
            1.8514 * munecaPulagada * (porcientoGrasa / 340 + 1);
        predictionModel.cuello =
            2.2574 * munecaPulagada * (porcientoGrasa / 340 + 1);
      } else {
        predictionModel.pecho =
            5.9881 * munecaPulagada * (porcientoGrasa / 340 + 1);
        predictionModel.biceps =
            2.1858 * munecaPulagada * (porcientoGrasa / 265 + 1);
        predictionModel.antebrazo =
            1.7588 * munecaPulagada * (porcientoGrasa / 340 + 1);
        predictionModel.cuello =
            2.1858 * munecaPulagada * (porcientoGrasa / 340 + 1);
      }

      if (ganadorDificilTobillo) {
        predictionModel.muslo =
            (2.5446 * tobilloPulgada) * ((porcientoGrasa / 190) + 1);
        predictionModel.pantorrilla =
            1.6891 * tobilloPulgada * (porcientoGrasa / 210 + 1);
      } else {
        predictionModel.muslo =
            2.6785 * tobilloPulgada * (porcientoGrasa / 190 + 1);
        predictionModel.pantorrilla =
            1.7780 * tobilloPulgada * (porcientoGrasa / 210 + 1);
      }
      double porcientoPesoMagro = 100 - porcientoGrasa;
      predictionModel.pesoTotal = convertLibrasToKilogramos(
          100 * predictionModel.pesoMagro / porcientoPesoMagro);
      predictionModel.pesoMagro =
          convertLibrasToKilogramos(predictionModel.pesoMagro);
      predictionModel.pesoGrasa =
          predictionModel.pesoTotal - predictionModel.pesoMagro;
      predictionModel.porcientoGrasa = porcientoGrasa;
    }

    return predictionModel;
  }

  Future<PredictionModel?> medidasEsteticasIdeales(
      double? porcientoGrasa) async {
    PersonalMeasure? personalMeasure =
        await _personalMeasureController.getLast();
    PredictionModel predictionModel =
        PredictionModel(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

    if (personalMeasure == null) {
      return null;
    }

    if (personalMeasure.sexo == 'Hombre') {
      if (porcientoGrasa != null) {
        double munecaPulgada = convertCmToPlg(personalMeasure.muneca);
        double estaturaPulgada = convertCmToPlg(personalMeasure.estatura);

        double cintura =
            (0.6412 * porcientoGrasa) + (2.3111 * munecaPulgada) + 7.6829;
        double caderas =
            (0.8015 * porcientoGrasa) + (2.8888 * munecaPulgada) + 9.6037;
        double pecho =
            (0.9078 * porcientoGrasa) + (3.2719 * munecaPulgada) + 10.8771;
        double hombros =
            (1.0375 * porcientoGrasa) + (3.7393 * munecaPulgada) + 12.4310;
        double cuello = 0.360 * pecho;
        double biceps = 0.360 * pecho;
        double antebrazo = 0.806 * biceps;
        double muslo = 0.530 * pecho;
        double pantorrilla = 0.679 * muslo;
        double pesoMagro =
            0.2709 * (biceps * biceps) + (3.0458 * estaturaPulgada) - 115.88;

        double porcientoPesoMagro = 100 - porcientoGrasa;
        predictionModel.pesoTotal =
            convertLibrasToKilogramos(100 * pesoMagro / porcientoPesoMagro);
        predictionModel.pecho = pecho;
        predictionModel.biceps = biceps;
        predictionModel.antebrazo = antebrazo;
        predictionModel.cuello = cuello;
        predictionModel.muslo = muslo;
        predictionModel.pantorrilla = pantorrilla;
        predictionModel.pesoMagro = convertLibrasToKilogramos(pesoMagro);
        predictionModel.porcientoGrasa = porcientoGrasa;
        predictionModel.pesoGrasa = convertLibrasToKilogramos(
            predictionModel.pesoTotal - predictionModel.pesoMagro);
      } else {
        predictionModel.pesoTotal = personalMeasure.peso;
        predictionModel.pecho = convertCmToPlg(personalMeasure.pecho);
        predictionModel.biceps = convertCmToPlg(personalMeasure.biceps);
        predictionModel.antebrazo = convertCmToPlg(personalMeasure.antebrazo);
        predictionModel.cuello = convertCmToPlg(personalMeasure.cuello);
        predictionModel.muslo = convertCmToPlg(personalMeasure.muslo);
        predictionModel.pantorrilla = convertCmToPlg(personalMeasure.gemelos);
        predictionModel.porcientoGrasa =
            await porcientoGrasaJacksonPollock(null);
        predictionModel.pesoMagro = await pesoMagro();
        predictionModel.porcientoGrasa =
            await porcientoGrasaJacksonPollock(null);
        predictionModel.pesoGrasa =
            predictionModel.pesoTotal - predictionModel.pesoMagro;
      }
    } else {
      var medida = MedidasIdealesMujer.list().firstWhere(
          (medida) => medida.estatura == personalMeasure.estatura / 100,
          orElse: () => MedidasIdealesMujer(
              estatura: 0,
              peso: 0,
              cuello: 0,
              hombro: 0,
              pecho: 0,
              brazo: 0,
              antebrazo: 0,
              cintura: 0,
              cadera: 0,
              muslo: 0,
              pantorrilla: 0));

      if (medida.estatura == 0) {
        return null;
      }

      if (porcientoGrasa == null) {
        predictionModel.antebrazo = convertCmToPlg(personalMeasure.antebrazo);
        predictionModel.biceps = convertCmToPlg(personalMeasure.biceps);
        predictionModel.cuello = convertCmToPlg(personalMeasure.cuello);
        predictionModel.muslo = convertCmToPlg(personalMeasure.muslo);
        predictionModel.pantorrilla = convertCmToPlg(personalMeasure.gemelos);
        predictionModel.pecho = convertCmToPlg(personalMeasure.pecho);
        predictionModel.pesoTotal = personalMeasure.peso;
        predictionModel.cintura = convertCmToPlg(personalMeasure.cintura);
        predictionModel.cadera = convertCmToPlg(personalMeasure.cadera);
        predictionModel.porcientoGrasa =
            await porcientoGrasaJacksonPollock(null);
      } else {
        predictionModel.antebrazo = convertCmToPlg(medida.antebrazo);
        predictionModel.biceps = convertCmToPlg(medida.brazo);
        predictionModel.cuello = convertCmToPlg(medida.cuello);
        predictionModel.muslo = convertCmToPlg(medida.muslo);
        predictionModel.pantorrilla = convertCmToPlg(medida.pantorrilla);
        predictionModel.pecho = convertCmToPlg(medida.pecho);
        predictionModel.pesoTotal = medida.peso;
        predictionModel.cintura = convertCmToPlg(medida.cintura);
        predictionModel.cadera = convertCmToPlg(medida.cadera);
        predictionModel.porcientoGrasa = porcientoGrasa;
      }
    }

    return predictionModel;
  }

  Future<double> pesoGrasa() async {
    PersonalMeasure? personalMeasure =
        await _personalMeasureController.getLast();
    double porcientoGrasa = await porcientoGrasaJacksonPollock(null);
    return porcientoGrasa * personalMeasure!.peso / 100;
  }

  Future<double> pesoMagro() async {
    PersonalMeasure? personalMeasure =
        await _personalMeasureController.getLast();

    return personalMeasure!.peso - await pesoGrasa();
  }

  double convertCmToPlg(double value) {
    return value / 2.54;
  }

  double convertPlgToCm(double value) {
    return value * 2.54;
  }

  double convertLibrasToKilogramos(double libras) {
    return libras * 0.453592;
  }
}
