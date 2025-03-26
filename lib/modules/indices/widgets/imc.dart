import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_fit_traker/modules/indices/infrastructure/indices_controller.dart';

class ImcWidget extends StatefulWidget {
  const ImcWidget({super.key});

  @override
  State<ImcWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ImcWidget> {
  final IndicesController indicesController = IndicesController();
  double imc = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _imc();
  }

  Future<void> _imc() async {
    setState(() {
      _isLoading = true;
    });
    final result = await indicesController.imc(null);
    imc = result;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (imc == 0) {
      return Center(child: Text('general.noData'.tr())); // No data available
    }
    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(
          text: '${'general.value'.tr()}: ${imc.toStringAsFixed(2)}\n\n',
          style: const TextStyle(color: Colors.black87, fontSize: 14),
          children: [
            TextSpan(
                style:
                    TextStyle(color: imc < 18.5 ? Colors.blue : Colors.black87),
                children: [
                  TextSpan(
                      text: '${'index.imcWidget.lowWeight'.tr()}: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                    text: '${'index.imcWidget.lowWeightDesc1'.tr()} 18.5 \n\n',
                  ),
                ]),
            TextSpan(
                style: TextStyle(
                    color: imc > 18.5 && imc < 24.9
                        ? Colors.blue
                        : Colors.black87),
                children: [
                  TextSpan(
                      text: '${'index.imcWidget.normalWeight'.tr()}: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                    text: '${'index.imcWidget.normalWeightDesc1'.tr(namedArgs: {
                          'value1': '18.5',
                          'value2': '24.9'
                        })} \n\n',
                  ),
                ]),
            TextSpan(
                style: TextStyle(
                    color:
                        imc > 25 && imc < 29.9 ? Colors.blue : Colors.black87),
                children: [
                  TextSpan(
                      text: '${'index.imcWidget.overWeight'.tr()}: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                    text: '${'index.imcWidget.overWeightDesc1'.tr(namedArgs: {
                          'value1': '25',
                          'value2': '29.9'
                        })} \n\n',
                  ),
                ]),
            TextSpan(
                style: TextStyle(
                    color:
                        imc > 30 && imc < 34.9 ? Colors.blue : Colors.black87),
                children: [
                  TextSpan(
                      text: '${'index.imcWidget.obesity'.tr()}: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                    text: '${'index.imcWidget.obesityDesc1'.tr(namedArgs: {
                          'value1': '30',
                          'value2': '34.9'
                        })} \n\n',
                  ),
                ]),
            TextSpan(
                style: TextStyle(
                    color:
                        imc > 35 && imc < 39.9 ? Colors.blue : Colors.black87),
                children: [
                  TextSpan(
                      text: '${'index.imcWidget.severeObesity'.tr()}: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                    text:
                        '${'index.imcWidget.severeObesityDesc1'.tr(namedArgs: {
                          'value1': '35',
                          'value2': '39.9'
                        })} \n\n',
                  ),
                ]),
            TextSpan(
                style:
                    TextStyle(color: imc >= 40 ? Colors.blue : Colors.black87),
                children: [
                  TextSpan(
                      text: '${'index.imcWidget.extremeObesity'.tr()}: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                    text: '${'index.imcWidget.extremeObesityDesc1'.tr()} \n\n',
                  ),
                ]),
          ]),
    );
  }
}
