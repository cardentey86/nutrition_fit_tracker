import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nutrition_fit_traker/modules/indices/models/progreso_model.dart';
import 'package:nutrition_fit_traker/modules/personal_measure/infrastructure/personal_measure_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PesoChartWidget extends StatefulWidget {
  final VoidCallback onClose;
  const PesoChartWidget({super.key, required this.onClose});

  @override
  State<PesoChartWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PesoChartWidget> {
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
    setState(() {
      _isLoading = true;
    });
    final result = await medidasPersonalesController.getAll();

    if (result.isNotEmpty) {
      result.sort((a, b) => a.fecha.compareTo(b.fecha));
      for (var element in result) {
        progressValues.add(ProgresoValores(
            date: element.fecha.toString(), value: element.peso));
      }

      model =
          ProgressModel(item: 'Peso Corporal', progressValues: progressValues);
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
    return SizedBox(
      height: 300,
      child: Stack(children: [
        SfCartesianChart(
          tooltipBehavior: _tooltipBehavior,
          onTooltipRender: (TooltipArgs args) {
            final peso = args.dataPoints![0].y;
            final fecha = args.dataPoints![0].x;
            args.text = '$fecha';
            args.header = 'Peso: ${peso.toStringAsFixed(1)} kg';
          },
          title: ChartTitle(
            text: model!.item,
            textStyle:
                const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          primaryXAxis: CategoryAxis(
            title: AxisTitle(text: 'Fecha'),
            labelStyle: const TextStyle(fontSize: 12, color: Colors.grey),
            axisLine: const AxisLine(color: Colors.grey),
            majorGridLines: const MajorGridLines(width: 0),
          ),
          primaryYAxis: NumericAxis(
            title: AxisTitle(text: 'Peso (kg)'),
            isVisible: false,
            labelStyle: const TextStyle(fontSize: 12, color: Colors.grey),
            axisLine: const AxisLine(color: Colors.grey),
            majorTickLines: const MajorTickLines(size: 0),
            majorGridLines: const MajorGridLines(dashArray: [4, 4]),
          ),
          plotAreaBorderWidth: 0,
          series: <CartesianSeries>[
            LineSeries<ProgresoValores, String>(
              name: 'Peso Kg',
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
    );
  }
}
