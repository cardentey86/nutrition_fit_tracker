import 'package:flutter/material.dart';
import 'package:nutrition_fit_traker/modules/menu/models/chart_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyChart extends StatefulWidget {
  final String title;
  final double maxValue;
  final Color seriesColor;
  final List<Data> data;

  const MyChart({
    super.key,
    required this.maxValue,
    required this.seriesColor,
    required this.data,
    required this.title,
  });

  @override
  State<MyChart> createState() => _MyChartWidgetState();
}

class _MyChartWidgetState extends State<MyChart> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: AlignmentDirectional.center, children: [
      SfCircularChart(
        series: <CircularSeries>[
          RadialBarSeries<Data, String>(
            dataSource: widget.data,
            xValueMapper: (Data data, _) => data.macro,
            yValueMapper: (Data data, _) => data.value,
            maximumValue: widget.maxValue,
            strokeColor: Colors.black,
            gap: '10',
            pointColorMapper: (datum, index) => widget.seriesColor,
            dataLabelSettings: DataLabelSettings(
                isVisible: true,
                textStyle: TextStyle(
                    color: widget.maxValue < widget.data.first.value
                        ? Colors.red
                        : Colors.black),
                labelPosition: ChartDataLabelPosition.inside),
            dataLabelMapper: (datum, index) =>
                '${datum.value} / ${widget.maxValue}',
          ),
        ],
      ),
      Text(widget.title)
    ]);
  }
}
