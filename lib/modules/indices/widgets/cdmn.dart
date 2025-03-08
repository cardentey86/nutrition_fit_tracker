import 'package:flutter/material.dart';
import 'package:nutrition_fit_traker/modules/indices/infrastructure/indices_controller.dart';
import 'package:nutrition_fit_traker/modules/personal_measure/infrastructure/personal_measure_controller.dart';
import 'package:nutrition_fit_traker/modules/personal_measure/models/measure_model.dart';
import 'package:nutrition_fit_traker/modules/personal_measure/models/objetivo.dart';

class CdmnWidget extends StatefulWidget {
  const CdmnWidget({super.key});

  @override
  State<CdmnWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CdmnWidget> {
  final IndicesController indicesController = IndicesController();
  final PersonalMeasureController controller = PersonalMeasureController();
  double cdmn = 0;
  PersonalMeasure? personalMeasure;
  Objetivo? objetivo;

  @override
  void initState() {
    super.initState();
    _cdmn();
    _objetivo();
  }

  void _cdmn() async {
    final result = await indicesController.consumoMacronutrientes();
    setState(() {
      cdmn = result;
    });
  }

  void _objetivo() async {
    var result = await controller.getLast();
    setState(() {
      objetivo = Objetivo()
          .objetivos()
          .firstWhere((obj) => obj.id == result?.objetivo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
        textAlign: TextAlign.justify,
        text: TextSpan(
          text: 'Valor: ${cdmn.toStringAsFixed(2)} kcal \n\n',
          style: const TextStyle(color: Colors.black87, fontSize: 14),
          children: [
            const TextSpan(
                text: 'Objetivo: ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
              text: ' ${objetivo?.name} \n\n',
            ),
            const TextSpan(
                text: '•	Proteínas: ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
              text:
                  '${(cdmn * (objetivo!.proteinas / 100)).toStringAsFixed(2)} kcal \u2248 ${((cdmn * (objetivo!.proteinas / 100)) / 4).toStringAsFixed(2)} g \n\n',
            ),
            const TextSpan(
                text: '•	Carbohidratos: ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
              text:
                  '${(cdmn * (objetivo!.carbohidratos / 100)).toStringAsFixed(2)} kcal \u2248 ${((cdmn * (objetivo!.proteinas / 100)) / 4).toStringAsFixed(2)} g \n\n',
            ),
            const TextSpan(
                text: '•	Grasas: ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
              text:
                  '${(cdmn * (objetivo!.grasas / 100)).toStringAsFixed(2)} kcal \u2248 ${((cdmn * (objetivo!.proteinas / 100)) / 9).toStringAsFixed(2)} g \n\n',
            )
          ],
        ));
  }
}
