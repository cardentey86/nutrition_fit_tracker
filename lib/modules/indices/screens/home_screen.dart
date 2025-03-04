import 'package:flutter/material.dart';
import 'package:nutrition_fit_traker/data/database_helper.dart';
import 'package:nutrition_fit_traker/modules/indices/infrastructure/indices_controller.dart';
import 'package:nutrition_fit_traker/modules/indices/widgets/indice_btn.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseHelper _helper = DatabaseHelper();
  final IndicesController indicesController = IndicesController();

  @override
  void initState() {
    super.initState();
    _helper.database.then((db) {}).catchError((error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Error on init database"),
        ));
      }
    });
  }

  void _showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(
      content: Text(text),
      action: SnackBarAction(
        label: 'Cerrar',
        onPressed: () {
          // Acción para cerrar el SnackBar
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          const SizedBox(
            height: 16.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IndiceBtn(
                text: 'IMC',
                image: 'assets/img/manwoman.svg',
                onTap: () => _showSnackBar(context,
                    'Indice de Masa Corporal: ${indicesController.imc().toString()}'),
              ),
              IndiceBtn(
                text: 'RMC',
                image: 'assets/img/manwoman.svg',
                onTap: () => _showSnackBar(context, 'Ritmo Máximo Cardiaco'),
              ),
              IndiceBtn(
                text: 'PGM',
                image: 'assets/img/manwoman.svg',
                onTap: () =>
                    _showSnackBar(context, 'Predición de Ganancia Muscular'),
              ),
            ],
          ),
          const SizedBox(
            height: 32.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IndiceBtn(
                text: 'PGC',
                image: 'assets/img/manwoman.svg',
                onTap: () =>
                    _showSnackBar(context, 'Porciento de grasa corporal'),
              ),
              IndiceBtn(
                text: 'PMM',
                image: 'assets/img/manwoman.svg',
                onTap: () =>
                    _showSnackBar(context, 'Porciento de músculo magro'),
              ),
              IndiceBtn(
                text: 'TMB',
                image: 'assets/img/manwoman.svg',
                onTap: () => _showSnackBar(context, 'Tasa metabólica basal'),
              ),
            ],
          ),
          const SizedBox(
            height: 32.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IndiceBtn(
                text: 'MI',
                image: 'assets/img/manwoman.svg',
                onTap: () => _showSnackBar(context, 'Medidas Ideales'),
              ),
              IndiceBtn(
                text: 'CDM',
                image: 'assets/img/manwoman.svg',
                onTap: () =>
                    _showSnackBar(context, 'Consumo diario de macronutrientes'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
