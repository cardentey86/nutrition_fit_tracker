import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nutrition_fit_traker/modules/indices/models/progreso_model.dart';
import 'package:nutrition_fit_traker/modules/personal_measure/infrastructure/personal_measure_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CinturaChartWidget extends StatefulWidget {
  final VoidCallback onClose;
  const CinturaChartWidget({super.key, required this.onClose});

  @override
  State<CinturaChartWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CinturaChartWidget> {
  final PersonalMeasureController medidasPersonalesController =
      PersonalMeasureController();
  List<ProgresoValores> progressValues = [];
  ProgressModel? model;
  bool _isLoading = true;
  TooltipBehavior _tooltipBehavior = TooltipBehavior(enable: true);

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final result = await medidasPersonalesController.getAll();
    if (!mounted) return;
    if (result.isNotEmpty) {
      result.sort((a, b) => a.fecha.compareTo(b.fecha));
      for (var element in result) {
        progressValues.add(ProgresoValores(
            date: element.fecha.toString(), value: element.cintura));
      }

      model = ProgressModel(item: 'Cintura cm', progressValues: progressValues);
    }
    if (!mounted) return;
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
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 4),
            blurRadius: 4.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: SizedBox(
        height: 250,
        child: Stack(children: [
          SfCartesianChart(
            tooltipBehavior: _tooltipBehavior,
            onTooltipRender: (TooltipArgs args) {
              final peso = args.dataPoints![0].y;
              final fecha = args.dataPoints![0].x;
              args.text = '$fecha';
              args.header = 'Cintura cm: ${peso.toStringAsFixed(1)}';
            },
            title: ChartTitle(
              text: model!.item,
              textStyle:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            primaryXAxis: CategoryAxis(
              title: AxisTitle(text: 'Fecha'),
              labelStyle: const TextStyle(fontSize: 12, color: Colors.grey),
              axisLine: const AxisLine(color: Colors.grey),
              majorGridLines: const MajorGridLines(width: 0),
            ),
            primaryYAxis: NumericAxis(
              title: AxisTitle(text: 'Cintura cm'),
              isVisible: false,
              labelStyle: const TextStyle(fontSize: 12, color: Colors.grey),
              axisLine: const AxisLine(color: Colors.grey),
              majorTickLines: const MajorTickLines(size: 0),
              majorGridLines: const MajorGridLines(dashArray: [4, 4]),
            ),
            plotAreaBorderWidth: 0,
            series: <CartesianSeries>[
              LineSeries<ProgresoValores, String>(
                name: 'Cintura',
                dataSource: model!.progressValues,
                xValueMapper: (ProgresoValores progreso, _) =>
                    DateFormat('dd/MM/yyyy')
                        .format(DateTime.parse(progreso.date)),
                yValueMapper: (ProgresoValores progreso, _) => progreso.value,
                dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                  textStyle: TextStyle(fontSize: 12, color: Colors.black),
                ),
                markerSettings: const MarkerSettings(
                  isVisible: true,
                ),
                color: Colors.lightBlue,
                width: 2,
                enableTooltip: true,
              ),
            ],
            enableAxisAnimation: true,
          ),
          Positioned(
              right: 0,
              child: IconButton(
                  onPressed: () {
                    widget.onClose();
                  },
                  icon: Icon(
                    Icons.close,
                  )))
        ]),
      ),
    );
  }
}
