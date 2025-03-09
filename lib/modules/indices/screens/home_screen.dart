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
          const SizedBox(
            height: 16.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IndiceBtn(
                  text: 'IMC',
                  image: 'assets/img/manwoman.svg',
                  onTap: () {
                    _mostrarBottomSheet(context,
                        'Indice de Masa Corporal (IMC)', const ImcWidget());
                  }),
              IndiceBtn(
                text: 'RMC',
                image: 'assets/img/manwoman.svg',
                onTap: () => _mostrarBottomSheet(
                    context, 'Ritmo Máximo Cardiaco (RMC)', const RmcWidget()),
              ),
              IndiceBtn(
                text: 'TMB',
                image: 'assets/img/manwoman.svg',
                onTap: () => _mostrarBottomSheet(
                    context, 'Tasa Metabólica Basal (TMB)', const TmbWidget()),
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
                onTap: () => _mostrarBottomSheet(context,
                    'Porciento de Grasa Corporal (PGC)', const PgcWidget()),
              ),
              IndiceBtn(
                text: 'PMM',
                image: 'assets/img/manwoman.svg',
                onTap: () => _mostrarBottomSheet(context,
                    'Porciento de Músculo Magro (PMM)', const PmmWidget()),
              ),
              IndiceBtn(
                text: 'CDM',
                image: 'assets/img/manwoman.svg',
                onTap: () => _mostrarBottomSheet(
                    context,
                    'Consumo Diario de Macronutrientes (CDM)',
                    const CdmnWidget()),
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
                text: 'PGM',
                image: 'assets/img/man.svg',
                onTap: () => _mostrarBottomSheet(
                    context,
                    'Predicción de Ganancia Muscular (PGM)',
                    const PrediccionGananciaWidget()),
              ),
              IndiceBtn(
                text: 'MI',
                image: 'assets/img/manwoman.svg',
                onTap: () => _mostrarBottomSheet(
                    context,
                    'Medidas Estéticas Ideales (MI)',
                    const MedidasEsteticasWidget()),
              ),
              IndiceBtn(
                text: 'PE',
                image: 'assets/img/man.svg',
                onTap: () => _showSnackBar(context, 'Proporciones Estéticas'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
