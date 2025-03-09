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
    prediccionGanancia.add(result12);
    final resultValue =
        await indicesController.prediccionGananciaMuscular(null);
    prediccionGanancia.add(resultValue);
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
            text: 'Comparación ganancia muscular en Plg y Kg',
            textStyle: const TextStyle(fontSize: 12)),
        legend: Legend(isVisible: true, position: LegendPosition.top),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries<dynamic, String>>[
          // Creamos una serie de líneas para cada modelo
          for (int i = 0; i < prediccionGanancia.length; i++)
            LineSeries<dynamic, String>(
              dataSource: campos.map((campo) {
                // Mapeamos los valores de los campos a la serie
                switch (campo) {
                  case 'Pecho':
                    return {
                      'campo': campo,
                      'valor': double.parse(
                          prediccionGanancia[i].pecho.toStringAsFixed(2))
                    };
                  case 'Biceps':
                    return {
                      'campo': campo,
                      'valor': double.parse(
                          prediccionGanancia[i].biceps.toStringAsFixed(2))
                    };
                  case 'Antebrazo':
                    return {
                      'campo': campo,
                      'valor': double.parse(
                          prediccionGanancia[i].antebrazo.toStringAsFixed(2))
                    };
                  case 'Muslo':
                    return {
                      'campo': campo,
                      'valor': double.parse(
                          prediccionGanancia[i].muslo.toStringAsFixed(2))
                    };
                  case 'Gemelo':
                    return {
                      'campo': campo,
                      'valor': double.parse(
                          prediccionGanancia[i].pantorrilla.toStringAsFixed(2))
                    };
                  case 'Cuello':
                    return {
                      'campo': campo,
                      'valor': double.parse(
                          prediccionGanancia[i].cuello.toStringAsFixed(2))
                    };
                  case 'MusculoKg':
                    return {
                      'campo': campo,
                      'valor': double.parse(
                          prediccionGanancia[i].pesoMagro.toStringAsFixed(2))
                    };
                  case 'PesoKg':
                    return {
                      'campo': campo,
                      'valor': double.parse(
                          prediccionGanancia[i].pesoTotal.toStringAsFixed(2))
                    };
                  case '%Grasa':
                    return {
                      'campo': campo,
                      'valor': double.parse(prediccionGanancia[i]
                          .porcientoGrasa
                          .toStringAsFixed(2))
                    };
                  case 'GrasaKg':
                    return {
                      'campo': campo,
                      'valor': double.parse(
                          prediccionGanancia[i].pesoGrasa.toStringAsFixed(2))
                    };
                  default:
                    return {'campo': campo, 'valor': 0.0}; // Valor por defecto
                }
              }).toList(),
              xValueMapper: (dynamic data, _) => data['campo'],
              yValueMapper: (dynamic data, _) => data['valor'],
              name:
                  'Grasa: ${double.parse(prediccionGanancia[i].porcientoGrasa.toStringAsFixed(2))} %',
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
