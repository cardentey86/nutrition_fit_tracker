import 'package:flutter/material.dart';
import 'package:nutrition_fit_traker/modules/indices/infrastructure/indices_controller.dart';

class TmbWidget extends StatefulWidget {
  const TmbWidget({super.key});

  @override
  State<TmbWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<TmbWidget> {
  final IndicesController indicesController = IndicesController();
  double tmb = 0;

  @override
  void initState() {
    super.initState();
    _tmb();
  }

  void _tmb() async {
    final result = await indicesController.tasaMetabolica(null);
    setState(() {
      tmb = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(
        text: 'Valor: $tmb kcal \n\n',
        style: const TextStyle(color: Colors.black87, fontSize: 14),
      ),
    );
  }
}
