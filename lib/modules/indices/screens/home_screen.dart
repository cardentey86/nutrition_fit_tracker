import 'package:flutter/material.dart';
import 'package:nutrition_fit_traker/data/database_helper.dart';
import 'package:nutrition_fit_traker/modules/indices/infrastructure/indices_controller.dart';
import 'package:nutrition_fit_traker/modules/indices/widgets/cdmn.dart';
import 'package:nutrition_fit_traker/modules/indices/widgets/imc.dart';
import 'package:nutrition_fit_traker/modules/indices/widgets/indice_btn.dart';
import 'package:nutrition_fit_traker/modules/indices/widgets/medidas_esteticas.dart';
import 'package:nutrition_fit_traker/modules/indices/widgets/pgc.dart';
import 'package:nutrition_fit_traker/modules/indices/widgets/pmm.dart';
import 'package:nutrition_fit_traker/modules/indices/widgets/prediccion_ganancia.dart';
import 'package:nutrition_fit_traker/modules/indices/widgets/rmc.dart';
import 'package:nutrition_fit_traker/modules/indices/widgets/tmb.dart';

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

  void _mostrarBottomSheet(BuildContext context, String title, Widget content) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          widthFactor: 1,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            Text(
                              title,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            content,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          ListTile(
              subtitle: const Text('Indice de Masa Corporal'),
              title: const Text('IMC'),
              leading: IndiceBtn(
                  text: 'IMC', image: 'assets/img/manwoman.svg', onTap: () {}),
              onTap: () => _mostrarBottomSheet(
                    context,
                    'Indice de Masa Corporal (IMC)',
                    const ImcWidget(),
                  )),
          ListTile(
              title: const Text('RMC'),
              subtitle: const Text('Ritmo Máximo Cardiaco '),
              leading: IndiceBtn(
                  text: 'IMC', image: 'assets/img/manwoman.svg', onTap: () {}),
              onTap: () => _mostrarBottomSheet(
                    context,
                    'Ritmo Máximo Cardiaco (RMC)',
                    const RmcWidget(),
                  )),
          ListTile(
              title: const Text('TMB'),
              subtitle: const Text('Tasa Metabólica Basal'),
              leading: IndiceBtn(
                  text: 'IMC', image: 'assets/img/manwoman.svg', onTap: () {}),
              onTap: () => _mostrarBottomSheet(
                    context,
                    'Tasa Metabólica Basal (TMB)',
                    const TmbWidget(),
                  )),
          ListTile(
              title: const Text('PGC'),
              subtitle: const Text('Porciento de Grasa Corporal'),
              leading: IndiceBtn(
                  text: 'IMC', image: 'assets/img/manwoman.svg', onTap: () {}),
              onTap: () => _mostrarBottomSheet(
                    context,
                    'Porciento de Grasa Corporal (PGC)',
                    const PgcWidget(),
                  )),
          ListTile(
              title: const Text('PMM'),
              subtitle: const Text('Porciento de Músculo Magro'),
              leading: IndiceBtn(
                  text: 'IMC', image: 'assets/img/manwoman.svg', onTap: () {}),
              onTap: () => _mostrarBottomSheet(
                    context,
                    'Porciento de Músculo Magro (PMM)',
                    const PmmWidget(),
                  )),
          ListTile(
              title: const Text('CDM'),
              subtitle: const Text('Consumo Diario de Macronutrientes'),
              leading: IndiceBtn(
                  text: 'IMC', image: 'assets/img/manwoman.svg', onTap: () {}),
              onTap: () => _mostrarBottomSheet(
                  context,
                  'Consumo Diario de Macronutrientes (CDM)',
                  const CdmnWidget())),
          ListTile(
              title: const Text('PGM'),
              subtitle: const Text('Predicción de Ganancia Muscular'),
              leading: IndiceBtn(
                  text: 'IMC', image: 'assets/img/man.svg', onTap: () {}),
              onTap: () => _mostrarBottomSheet(
                  context,
                  'Predicción de Ganancia Muscular (PGM)',
                  const PrediccionGananciaWidget())),
          ListTile(
              title: const Text('MI'),
              subtitle: const Text('Medidas Estéticas Ideales '),
              leading: IndiceBtn(
                  text: 'IMC', image: 'assets/img/manwoman.svg', onTap: () {}),
              onTap: () => _mostrarBottomSheet(
                  context,
                  'Medidas Estéticas Ideales (MI)',
                  const MedidasEsteticasWidget())),
        ],
      ),
    );
  }
}
