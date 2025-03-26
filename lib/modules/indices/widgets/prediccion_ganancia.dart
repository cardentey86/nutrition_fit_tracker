import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_fit_traker/modules/indices/infrastructure/indices_controller.dart';
import 'package:nutrition_fit_traker/modules/indices/models/prediction_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PrediccionGananciaWidget extends StatefulWidget {
  const PrediccionGananciaWidget({super.key});

  @override
  State<PrediccionGananciaWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PrediccionGananciaWidget> {
  final IndicesController indicesController = IndicesController();
  List<PredictionModel> prediccionGanancia = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _prediccionGanancia();
  }

  Future<void> _prediccionGanancia() async {
    setState(() {
      _isLoading = true;
    });
    final result12 = await indicesController.prediccionGananciaMuscular(12);
    if (result12 != null) {
      prediccionGanancia.add(result12);
    }

    final resultValue =
        await indicesController.prediccionGananciaMuscular(null);
    if (resultValue != null) {
      prediccionGanancia.add(resultValue);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (prediccionGanancia.isEmpty) {
      return Center(child: Text('general.noData'.tr()));
    }

    final List<String> campos = [
      'general.body.chest',
      'general.body.biceps',
      'general.body.forearm',
      'general.body.thigh',
      'general.body.calf',
      'general.body.neck',
      'general.body.muscleKg',
      'general.body.weightKg',
      'general.body.fatPercentage',
      'general.body.fatKg'
    ];

    return SizedBox(
      height: 500,
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(labelRotation: -55),
        primaryYAxis: NumericAxis(
          isVisible: false, // Oculta los valores del eje Y
        ),
        title: ChartTitle(
            text: 'index.pgmWidget.title'.tr(),
            textStyle: const TextStyle(fontSize: 12)),
        legend: Legend(isVisible: true, position: LegendPosition.top),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries<dynamic, String>>[
          // Creamos una serie de líneas para cada modelo
          for (int i = 0; i < prediccionGanancia.length; i++)
            LineSeries<dynamic, String>(
              dataSource: campos.map((campo) {
                String translatedField = campo.tr();
                // Mapeamos los valores de los campos a la serie
                switch (campo) {
                  case 'general.body.chest':
                    return {
                      'campo': translatedField,
                      'valor': double.parse(
                          prediccionGanancia[i].pecho.toStringAsFixed(2))
                    };
                  case 'general.body.biceps':
                    return {
                      'campo': translatedField,
                      'valor': double.parse(
                          prediccionGanancia[i].biceps.toStringAsFixed(2))
                    };
                  case 'general.body.forearm':
                    return {
                      'campo': 'general.body.forearm'.tr(),
                      'valor': double.parse(
                          prediccionGanancia[i].antebrazo.toStringAsFixed(2))
                    };
                  case 'general.body.thigh':
                    return {
                      'campo': translatedField,
                      'valor': double.parse(
                          prediccionGanancia[i].muslo.toStringAsFixed(2))
                    };
                  case 'general.body.calf':
                    return {
                      'campo': translatedField,
                      'valor': double.parse(
                          prediccionGanancia[i].pantorrilla.toStringAsFixed(2))
                    };
                  case 'general.body.neck':
                    return {
                      'campo': translatedField,
                      'valor': double.parse(
                          prediccionGanancia[i].cuello.toStringAsFixed(2))
                    };
                  case 'general.body.muscleKg':
                    return {
                      'campo': 'general.body.muscleKg'.tr(),
                      'valor': double.parse(
                          prediccionGanancia[i].pesoMagro.toStringAsFixed(2))
                    };
                  case 'general.body.weightKg':
                    return {
                      'campo': translatedField,
                      'valor': double.parse(
                          prediccionGanancia[i].pesoTotal.toStringAsFixed(2))
                    };
                  case 'general.body.fatPercentage':
                    return {
                      'campo': translatedField,
                      'valor': double.parse(prediccionGanancia[i]
                          .porcientoGrasa
                          .toStringAsFixed(2))
                    };
                  case 'general.body.fatKg':
                    return {
                      'campo': translatedField,
                      'valor': double.parse(
                          prediccionGanancia[i].pesoGrasa.toStringAsFixed(2))
                    };
                  default:
                    return {
                      'campo': translatedField,
                      'valor': 0.0
                    }; // Valor por defecto
                }
              }).toList(),
              xValueMapper: (dynamic data, _) => data['campo'],
              yValueMapper: (dynamic data, _) => data['valor'],
              name:
                  '${'general.macro.fat'.tr()}: ${double.parse(prediccionGanancia[i].porcientoGrasa.toStringAsFixed(2))} %',
              markerSettings: const MarkerSettings(isVisible: true),
              dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                  textStyle: TextStyle(fontSize: 10),
                  labelAlignment: ChartDataLabelAlignment.top),
            ),
        ],
      ),
    );
  }
}
