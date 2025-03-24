import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nutrition_fit_traker/modules/menu/models/chart_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraficoPastel extends StatelessWidget {
  final List<Data> macros;
  final String nombreMacro;

  const GraficoPastel(
      {super.key, required this.macros, required this.nombreMacro});

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      title: ChartTitle(text: nombreMacro),
      legend: Legend(isVisible: true, position: LegendPosition.right),
      series: <CircularSeries>[
        PieSeries<Data, String>(
          dataSource: macros,
          xValueMapper: (Data menu, _) => menu.macro,
          yValueMapper: (Data menu, _) => menu.value,
          dataLabelMapper: (Data menu, _) => menu.value.toString(),
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          pointColorMapper: (Data menu, _) {
            return getRandomColor();
          },
        )
      ],
    );
  }

  Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255, // Alpha
      random.nextInt(256), // Rojo
      random.nextInt(256), // Verde
      random.nextInt(256), // Azul
    );
  }
}
