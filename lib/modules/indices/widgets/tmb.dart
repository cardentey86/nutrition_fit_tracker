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
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _tmb();
  }

  Future<void> _tmb() async {
    setState(() {
      _isLoading = true;
    });

    final result = await indicesController.tasaMetabolica(null);
    tmb = result;

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
        text: 'Valor: $tmb kcal \n\n',
        style: const TextStyle(color: Colors.black87, fontSize: 14),
      ),
    );
  }
}
