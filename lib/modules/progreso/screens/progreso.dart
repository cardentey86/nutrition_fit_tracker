import 'package:flutter/material.dart';
import 'package:nutrition_fit_traker/data/database_helper.dart';
import 'package:nutrition_fit_traker/modules/indices/infrastructure/indices_controller.dart';
import 'package:nutrition_fit_traker/modules/progreso/widgets/biceps_chart.dart';
import 'package:nutrition_fit_traker/modules/progreso/widgets/cintura_chart.dart';
import 'package:nutrition_fit_traker/modules/progreso/widgets/imc_chart.dart';
import 'package:nutrition_fit_traker/modules/progreso/widgets/muslo_chart.dart';
import 'package:nutrition_fit_traker/modules/progreso/widgets/pantorrilla_chart.dart';
import 'package:nutrition_fit_traker/modules/progreso/widgets/pecho_chart.dart';
import 'package:nutrition_fit_traker/modules/progreso/widgets/peso_chart.dart';
import 'package:nutrition_fit_traker/modules/progreso/widgets/pgc_chart.dart';
import 'package:nutrition_fit_traker/modules/progreso/widgets/pmm_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class ProgresoWidget extends StatefulWidget {
  const ProgresoWidget({super.key});

  @override
  State<ProgresoWidget> createState() => _ProgresoWidgetState();
}

class _ProgresoWidgetState extends State<ProgresoWidget> {
  final DatabaseHelper _helper = DatabaseHelper();

  final IndicesController indicesController = IndicesController();

  bool showPeso = false;

  bool showImc = false;

  bool showPgc = false;

  bool showPmm = false;

  bool showPecho = false;

  bool showBiceps = false;

  bool showCintura = false;

  bool showMuslo = false;

  bool showPantorrilla = false;

  @override
  void initState() {
    loadPreferences();
    super.initState();
  }

  Future<void> loadPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      showPeso = prefs.getBool('showPeso') ?? false;
      showImc = prefs.getBool('showImc') ?? false;
      showPgc = prefs.getBool('showPgc') ?? false;
      showPmm = prefs.getBool('showPmm') ?? false;
      showPecho = prefs.getBool('showPecho') ?? false;
      showBiceps = prefs.getBool('showBiceps') ?? false;
      showCintura = prefs.getBool('showCintura') ?? false;
      showMuslo = prefs.getBool('showMuslo') ?? false;
      showPantorrilla = prefs.getBool('showPantorrilla') ?? false;
    });
  }

  void closeChart(String key) async {
    final pref = await SharedPreferences.getInstance();
    switch (key) {
      case "peso":
        {
          pref.setBool('showPeso', false);
          if (!mounted) return;
          setState(() {
            showPeso = false;
          });
        }
        break;
      case "imc":
        {
          pref.setBool('showImc', false);
          if (!mounted) return;
          setState(() {
            showImc = false;
          });
        }
        break;
      case "pgc":
        {
          pref.setBool('showPgc', false);
          if (!mounted) return;
          setState(() {
            showPgc = false;
          });
        }
        break;
      case "pmm":
        {
          pref.setBool('showPmm', false);
          if (!mounted) return;
          setState(() {
            showPmm = false;
          });
        }
        break;
      case "pecho":
        {
          pref.setBool('showPecho', false);
          if (!mounted) return;
          setState(() {
            showPecho = false;
          });
        }
        break;
      case "biceps":
        {
          pref.setBool('showBiceps', false);
          if (!mounted) return;
          setState(() {
            showBiceps = false;
          });
        }
        break;
      case "cintura":
        {
          pref.setBool('showCintura', false);
          if (!mounted) return;
          setState(() {
            showCintura = false;
          });
        }
        break;
      case "muslo":
        {
          pref.setBool('showMuslo', false);
          if (!mounted) return;
          setState(() {
            showMuslo = false;
          });
        }
        break;
      case "pantorrilla":
        {
          pref.setBool('showPantorrilla', false);
          if (!mounted) return;
          setState(() {
            showPantorrilla = false;
          });
        }
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Progreso',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            if (showPeso) PesoChartWidget(onClose: () => closeChart('peso')),
            if (showPeso)
              SizedBox(
                height: 16,
              ),
            if (showImc) ImcChartWidget(onClose: () => closeChart('imc')),
            if (showImc)
              SizedBox(
                height: 16,
              ),
            if (showPgc) PgcChartWidget(onClose: () => closeChart('pgc')),
            if (showPgc)
              SizedBox(
                height: 16,
              ),
            if (showPmm) PmmChartWidget(onClose: () => closeChart('pmm')),
            if (showPmm)
              SizedBox(
                height: 16,
              ),
            if (showPecho) PechoChartWidget(onClose: () => closeChart('pecho')),
            if (showPecho)
              SizedBox(
                height: 16,
              ),
            if (showBiceps)
              BicepsChartWidget(onClose: () => closeChart('biceps')),
            if (showBiceps)
              SizedBox(
                height: 16,
              ),
            if (showCintura)
              CinturaChartWidget(onClose: () => closeChart('cintura')),
            if (showCintura)
              SizedBox(
                height: 16,
              ),
            if (showMuslo) MusloChartWidget(onClose: () => closeChart('muslo')),
            if (showMuslo)
              SizedBox(
                height: 16,
              ),
            if (showPantorrilla)
              PantorrillaChartWidget(onClose: () => closeChart('pantorrilla')),
            if (showPantorrilla)
              SizedBox(
                height: 16,
              ),
          ],
        ),
      ),
    );
  }
}
