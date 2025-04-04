import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_fit_traker/modules/indices/infrastructure/indices_controller.dart';
import 'package:nutrition_fit_traker/modules/personal_measure/infrastructure/personal_measure_controller.dart';
import 'package:nutrition_fit_traker/modules/personal_measure/models/measure_model.dart';
import 'package:nutrition_fit_traker/modules/personal_measure/models/objetivo.dart';

class CdmnWidget extends StatefulWidget {
  const CdmnWidget({super.key});

  @override
  State<CdmnWidget> createState() => _CdmnWidgetState();
}

class _CdmnWidgetState extends State<CdmnWidget> {
  final IndicesController indicesController = IndicesController();
  final PersonalMeasureController controller = PersonalMeasureController();
  double cdmn = 0;
  PersonalMeasure? personalMeasure;
  Objetivo? objetivo;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    final cdmnResult = await indicesController.consumoMacronutrientes();
    cdmn = cdmnResult;

    PersonalMeasure? result = await controller.getLast();
    personalMeasure = result;
    if (result?.objetivo != null) {
      objetivo = Objetivo()
          .objetivos()
          .firstWhere((obj) => obj.id == result?.objetivo);
    }
    setState(() {
      _isLoading = false;
    });
  }

  String objetivoTraducido(int idObjetivo) {
    switch (idObjetivo) {
      case 1:
        return 'index.cdmWidget.lossWeight'.tr();
      case 2:
        return 'index.cdmWidget.gainWeight'.tr();
      case 3:
        return 'index.cdmWidget.maintainWeight'.tr();
      default:
        return 'index.cdmWidget.notDefined'.tr();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
          child: CircularProgressIndicator()); // Muestra un indicador de carga
    }
    if (personalMeasure == null) {
      return Center(child: Text('general.noData'.tr()));
    }
    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(
        style: const TextStyle(color: Colors.black87, fontSize: 14),
        children: [
          TextSpan(
              text: '${'index.cdmWidget.objective'.tr()}: ',
              style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(
            text: '${objetivoTraducido(objetivo!.id)} \n\n',
          ),
          TextSpan(
              text: '•	${'general.calory'.tr()}: ',
              style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: '${cdmn.toStringAsFixed(2)} kcal \n\n'),
          TextSpan(
              text: '•	${'general.protein'.tr()}: ',
              style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(
            text:
                '${(cdmn * (objetivo!.proteinas / 100)).toStringAsFixed(2)} kcal \u2248 ${((cdmn * (objetivo!.proteinas / 100)) / 4).toStringAsFixed(2)} g \n\n',
          ),
          TextSpan(
              text: '•	${'general.carbo'.tr()}: ',
              style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(
            text:
                '${(cdmn * (objetivo!.carbohidratos / 100)).toStringAsFixed(2)} kcal \u2248 ${((cdmn * (objetivo!.carbohidratos / 100)) / 4).toStringAsFixed(2)} g \n\n',
          ),
          TextSpan(
              text: '•	${'general.fats'.tr()}: ',
              style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(
            text:
                '${(cdmn * (objetivo!.grasas / 100)).toStringAsFixed(2)} kcal \u2248 ${((cdmn * (objetivo!.grasas / 100)) / 9).toStringAsFixed(2)} g \n\n',
          )
        ],
      ),
    );
  }
}
