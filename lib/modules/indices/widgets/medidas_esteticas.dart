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
      return const Center(child: Text('No hay datos disponibles'));
    }

    final List<String> campos = [
      'Pecho',
      'Biceps',
      'Antebrazo',
      'Muslo',
      'Gemelo',
      'Cuello',
      'MusculoKg',
      'PesoKg',
      '%Grasa',
      'GrasaKg'
    ];

    return SizedBox(
      height: 500,
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(labelRotation: -55),
        primaryYAxis: NumericAxis(
          isVisible: false, // Oculta los valores del eje Y
        ),
        title: ChartTitle(
            text: 'Comparación de Medidas en Pulgadas y Kg',
            textStyle: const TextStyle(fontSize: 12)),
        legend: Legend(isVisible: true, position: LegendPosition.top),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries<dynamic, String>>[
          // Creamos una serie de líneas para cada modelo
          for (int i = 0; i < medidasEsteticas.length; i++)
            LineSeries<dynamic, String>(
              dataSource: campos.map((campo) {
                // Mapeamos los valores de los campos a la serie
                switch (campo) {
                  case 'Pecho':
                    return {
                      'campo': campo,
                      'valor': double.parse(
                          medidasEsteticas[i]!.pecho.toStringAsFixed(2))
                    };
                  case 'Biceps':
                    return {
                      'campo': campo,
                      'valor': double.parse(
                          medidasEsteticas[i]!.biceps.toStringAsFixed(2))
                    };
                  case 'Antebrazo':
                    return {
                      'campo': campo,
                      'valor': double.parse(
                          medidasEsteticas[i]!.antebrazo.toStringAsFixed(2))
                    };
                  case 'Muslo':
                    return {
                      'campo': campo,
                      'valor': double.parse(
                          medidasEsteticas[i]!.muslo.toStringAsFixed(2))
                    };
                  case 'Gemelo':
                    return {
                      'campo': campo,
                      'valor': double.parse(
                          medidasEsteticas[i]!.pantorrilla.toStringAsFixed(2))
                    };
                  case 'Cuello':
                    return {
                      'campo': campo,
                      'valor': double.parse(
                          medidasEsteticas[i]!.cuello.toStringAsFixed(2))
                    };
                  case 'MusculoKg':
                    return {
                      'campo': campo,
                      'valor': double.parse(
                          medidasEsteticas[i]!.pesoMagro.toStringAsFixed(2))
                    };
                  case 'PesoKg':
                    return {
                      'campo': campo,
                      'valor': double.parse(
                          medidasEsteticas[i]!.pesoTotal.toStringAsFixed(2))
                    };
                  case '%Grasa':
                    return {
                      'campo': campo,
                      'valor': double.parse(medidasEsteticas[i]!
                          .porcientoGrasa
                          .toStringAsFixed(2))
                    };
                  case 'GrasaKg':
                    return {
                      'campo': campo,
                      'valor': double.parse(
                          medidasEsteticas[i]!.pesoGrasa.toStringAsFixed(2))
                    };
                  default:
                    return {'campo': campo, 'valor': 0.0}; // Valor por defecto
                }
              }).toList(),
              xValueMapper: (dynamic data, _) => data['campo'],
              yValueMapper: (dynamic data, _) => data['valor'],
              name:
                  'Grasa: ${double.parse(medidasEsteticas[i]!.porcientoGrasa.toStringAsFixed(2))} %',
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
