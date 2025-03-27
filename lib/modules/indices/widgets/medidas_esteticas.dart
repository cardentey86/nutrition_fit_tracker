import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_fit_traker/modules/indices/infrastructure/indices_controller.dart';
import 'package:nutrition_fit_traker/modules/indices/models/prediction_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MedidasEsteticasWidget extends StatefulWidget {
  const MedidasEsteticasWidget({super.key});

  @override
  State<MedidasEsteticasWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MedidasEsteticasWidget> {
  final IndicesController indicesController = IndicesController();
  List<PredictionModel?> medidasEsteticas = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _medidasEsteticas();
  }

  Future<void> _medidasEsteticas() async {
    setState(() {
      _isLoading = true;
    });
    final result12 = await indicesController.medidasEsteticasIdeales(12);
    if (result12 != null) {
      medidasEsteticas.add(result12);
    }
    final resultValue = await indicesController.medidasEsteticasIdeales(null);
    if (resultValue != null) {
      medidasEsteticas.add(resultValue);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void showSnackBar(BuildContext context, String s) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(s),
    ));
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (medidasEsteticas.isEmpty) {
      return Center(child: Text('general.noData'.tr()));
    }

    final List<String> campos =
        medidasEsteticas.any((medida) => medida!.cadera! == 0)
            ? [
                'general.body.chest',
                'general.body.biceps',
                'general.body.forearm',
                'general.body.thigh',
                'general.body.calf',
                'general.body.neck',
                'general.body.muscleKg',
                'general.body.weightKg',
                'general.body.fatPercentage',
                'general.body.fatKg',
              ]
            : [
                'general.body.chest',
                'general.body.biceps',
                'general.body.forearm',
                'general.body.thigh',
                'general.body.calf',
                'general.body.neck',
                'general.body.waist',
                'general.body.hip',
                'general.body.weightKg',
                'general.body.fatPercentage',
              ];

    return SizedBox(
      height: 500,
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(labelRotation: -55),
        primaryYAxis: NumericAxis(
          isVisible: false, // Oculta los valores del eje Y
        ),
        title: ChartTitle(
            text: 'index.meWidget.title'.tr(),
            textStyle: const TextStyle(fontSize: 12)),
        legend: Legend(isVisible: true, position: LegendPosition.top),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries<dynamic, String>>[
          // Creamos una serie de líneas para cada modelo
          for (int i = 0; i < medidasEsteticas.length; i++)
            LineSeries<dynamic, String>(
              dataSource: campos.map((campo) {
                String translatedField = campo.tr();
                // Mapeamos los valores de los campos a la serie
                switch (campo) {
                  case 'general.body.chest':
                    return {
                      'campo': translatedField,
                      'valor': double.parse(
                          medidasEsteticas[i]!.pecho.toStringAsFixed(2))
                    };
                  case 'general.body.biceps':
                    return {
                      'campo': translatedField,
                      'valor': double.parse(
                          medidasEsteticas[i]!.biceps.toStringAsFixed(2))
                    };
                  case 'general.body.forearm':
                    return {
                      'campo': translatedField,
                      'valor': double.parse(
                          medidasEsteticas[i]!.antebrazo.toStringAsFixed(2))
                    };
                  case 'general.body.thigh':
                    return {
                      'campo': translatedField,
                      'valor': double.parse(
                          medidasEsteticas[i]!.muslo.toStringAsFixed(2))
                    };
                  case 'general.body.calf':
                    return {
                      'campo': translatedField,
                      'valor': double.parse(
                          medidasEsteticas[i]!.pantorrilla.toStringAsFixed(2))
                    };
                  case 'general.body.neck':
                    return {
                      'campo': translatedField,
                      'valor': double.parse(
                          medidasEsteticas[i]!.cuello.toStringAsFixed(2))
                    };
                  case 'general.body.muscleKg':
                    return {
                      'campo': translatedField,
                      'valor': double.parse(
                          medidasEsteticas[i]!.pesoMagro.toStringAsFixed(2))
                    };
                  case 'general.body.weightKg':
                    return {
                      'campo': translatedField,
                      'valor': double.parse(
                          medidasEsteticas[i]!.pesoTotal.toStringAsFixed(2))
                    };
                  case 'general.body.fatPercentage':
                    return {
                      'campo': translatedField,
                      'valor': double.parse(medidasEsteticas[i]!
                          .porcientoGrasa
                          .toStringAsFixed(2))
                    };
                  case 'general.body.fatKg':
                    return {
                      'campo': campo,
                      'valor': double.parse(
                          medidasEsteticas[i]!.pesoGrasa.toStringAsFixed(2))
                    };
                  case 'general.body.waist':
                    return {
                      'campo': campo,
                      'valor': double.parse(
                          medidasEsteticas[i]!.cintura!.toStringAsFixed(2))
                    };
                  case 'general.body.hip':
                    return {
                      'campo': campo,
                      'valor': double.parse(
                          medidasEsteticas[i]!.cadera!.toStringAsFixed(2))
                    };
                  default:
                    return {'campo': campo, 'valor': 0.0}; // Valor por defecto
                }
              }).toList(),
              xValueMapper: (dynamic data, _) => data['campo'],
              yValueMapper: (dynamic data, _) => data['valor'],
              name:
                  '${'general.macro.fat'.tr()}: ${double.parse(medidasEsteticas[i]!.porcientoGrasa.toStringAsFixed(2))} %',
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
