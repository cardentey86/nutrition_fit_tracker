import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_fit_traker/modules/indices/infrastructure/indices_controller.dart';
import 'package:nutrition_fit_traker/modules/personal_measure/infrastructure/personal_measure_controller.dart';
import 'package:nutrition_fit_traker/modules/personal_measure/models/measure_model.dart';

class PgcWidget extends StatefulWidget {
  const PgcWidget({super.key});

  @override
  State<PgcWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PgcWidget> {
  final IndicesController indicesController = IndicesController();
  final PersonalMeasureController personalMeasureController =
      PersonalMeasureController();
  double pgc = 0;
  PersonalMeasure? personalMeasure;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _pgc();
  }

  Future<void> _pgc() async {
    setState(() {
      _isLoading = true;
    });
    personalMeasure = await personalMeasureController.getLast();
    final result =
        await indicesController.porcientoGrasaJacksonPollock(personalMeasure);
    pgc = result;

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
      return Center(child: Text('general.noData'.tr()));
    }
    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(
        text:
            '${'general.value'.tr()}: ${pgc.toStringAsFixed(2)} % \u2248 ${(personalMeasure!.peso * (pgc / 100)).toStringAsFixed(0)} kg \n\n',
        style: const TextStyle(color: Colors.black87, fontSize: 14),
      ),
    );
  }
}
