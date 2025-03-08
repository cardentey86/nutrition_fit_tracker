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
    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(
          text: 'Valor: ${imc.toStringAsFixed(2)}\n\n',
          style: const TextStyle(color: Colors.black87, fontSize: 14),
          children: [
            TextSpan(
                style:
                    TextStyle(color: imc < 18.5 ? Colors.blue : Colors.black87),
                children: const [
                  TextSpan(
                      text: 'Bajo Peso: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                    text: 'IMC menor de 18.5 \n\n',
                  ),
                ]),
            TextSpan(
                style: TextStyle(
                    color: imc > 18.5 && imc < 24.9
                        ? Colors.blue
                        : Colors.black87),
                children: const [
                  TextSpan(
                      text: 'Peso Normal: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                    text: 'IMC de 18.5 a 24.9 \n\n',
                  ),
                ]),
            TextSpan(
                style: TextStyle(
                    color:
                        imc > 25 && imc < 29.9 ? Colors.blue : Colors.black87),
                children: const [
                  TextSpan(
                      text: 'Sobrepeso: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                    text: 'IMC de 25 a 29.9 \n\n',
                  ),
                ]),
            TextSpan(
                style: TextStyle(
                    color:
                        imc > 30 && imc < 34.9 ? Colors.blue : Colors.black87),
                children: const [
                  TextSpan(
                      text: 'Obesidad moderada: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                    text: 'IMC de 30 a 34.9 \n\n',
                  ),
                ]),
            TextSpan(
                style: TextStyle(
                    color:
                        imc > 35 && imc < 39.9 ? Colors.blue : Colors.black87),
                children: const [
                  TextSpan(
                      text: 'Obesidad severa: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                    text: 'IMC de 35 a 39.9 \n\n',
                  ),
                ]),
            TextSpan(
                style:
                    TextStyle(color: imc >= 40 ? Colors.blue : Colors.black87),
                children: const [
                  TextSpan(
                      text: 'Obesidad mórbida: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                    text: 'IMC de 40 o más \n\n',
                  ),
                ]),
          ]),
    );
  }
}
