import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_fit_traker/modules/indices/infrastructure/indices_controller.dart';

class RmcWidget extends StatefulWidget {
  const RmcWidget({super.key});

  @override
  State<RmcWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<RmcWidget> {
  final IndicesController indicesController = IndicesController();
  int rmc = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _rmc();
  }

  Future<void> _rmc() async {
    setState(() {
      _isLoading = true;
    });
    final result = await indicesController.rmc();
    rmc = result;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (rmc == 0) {
      return Center(child: Text('general.noData'.tr())); // No data available
    }
    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(
          text: '${'general.value'.tr()}: $rmc \n\n',
          style: const TextStyle(color: Colors.black87, fontSize: 14),
          children: [
            TextSpan(
                text:
                    '${'index.rmcWidget.title1'.tr()} (${(rmc * 0.6).toStringAsFixed(0)} - ${(rmc * 0.7).toStringAsFixed(0)}): ',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
              text: '${'index.rmcWidget.desc1'.tr()} \n\n',
            ),
            TextSpan(
                text:
                    '${'index.rmcWidget.title2'.tr()} (${(rmc * 0.8).toStringAsFixed(0)} - ${(rmc * 0.9).toStringAsFixed(0)}): ',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
              text: '${'index.rmcWidget.desc2'.tr()} \n\n',
            )
          ]),
    );
  }
}
