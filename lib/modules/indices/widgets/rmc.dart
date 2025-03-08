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
    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(
          text: 'Valor: $rmc \n\n',
          style: const TextStyle(color: Colors.black87, fontSize: 14),
          children: [
            TextSpan(
                text:
                    'Entrenamiento de resistencia (${(rmc * 0.6).toStringAsFixed(0)} - ${(rmc * 0.7).toStringAsFixed(0)}): ',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const TextSpan(
              text:
                  'Mantenerse en un rango del 60-70% del RMC ayuda a mejorar la capacidad aeróbica \n\n',
            ),
            TextSpan(
                text:
                    'Entrenamiento de potencia (${(rmc * 0.8).toStringAsFixed(0)} - ${(rmc * 0.9).toStringAsFixed(0)}): ',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const TextSpan(
              text:
                  'Alcanzar el 80-90% del RMC puede ser beneficioso para mejorar la fuerza y la velocidad \n\n',
            )
          ]),
    );
  }
}
