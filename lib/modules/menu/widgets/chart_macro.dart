import 'package:flutter/material.dart';
import 'package:nutrition_fit_traker/modules/menu/models/chart_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraficoPastel extends StatelessWidget {
  final List<Data> macros;

  const GraficoPastel({super.key, required this.macros});

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      title: ChartTitle(text: 'Calorías'),
      legend: Legend(isVisible: true, position: LegendPosition.right),
      series: <CircularSeries>[
        PieSeries<Data, String>(
          dataSource: macros,
          xValueMapper: (Data menu, _) => menu.macro,
          yValueMapper: (Data menu, _) => menu.value,
          dataLabelMapper: (Data menu, _) =>
              '${menu.macro} \n ${menu.value.toString()}',
          dataLabelSettings: const DataLabelSettings(isVisible: true),
        )
      ],
    );
  }
}
