import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_fit_traker/modules/indices/infrastructure/indices_controller.dart';
import 'package:nutrition_fit_traker/modules/personal_measure/infrastructure/personal_measure_controller.dart';
import 'package:nutrition_fit_traker/modules/personal_measure/models/measure_model.dart';

class PmmWidget extends StatefulWidget {
  const PmmWidget({super.key});

  @override
  State<PmmWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PmmWidget> {
  final IndicesController indicesController = IndicesController();
  final PersonalMeasureController personalMeasureController =
      PersonalMeasureController();
  double pmm = 0;
  PersonalMeasure? personalMeasure;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _pmm();
  }

  Future<void> _pmm() async {
    setState(() {
      _isLoading = true;
    });
    personalMeasure = await personalMeasureController.getLast();
    final pgc = await indicesController.porcientoGrasaJacksonPollock(null);
    pmm = 100 - pgc;

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (personalMeasure == null) {
      return Center(child: Text('general.noData'.tr())); // No data available
    }
    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(
          text:
              '${'general.value'.tr()}: ${pmm.toStringAsFixed(2)} % \u2248 ${(personalMeasure!.peso * (pmm / 100)).toStringAsFixed(0)} kg \n\n',
          style: const TextStyle(color: Colors.black87, fontSize: 14),
          children: [
            TextSpan(text: 'index.pmmWidget'.tr()),
          ]),
    );
  }
}
