import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/game_icons.dart';
import 'package:iconify_flutter/icons/healthicons.dart';
import 'package:iconify_flutter/icons/icon_park_outline.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({super.key});

  @override
  State<ConfigScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ConfigScreen> {
  String? _selectedLanguage;
  final List<String> _languages = ['Español', 'Inglés', 'Francés', 'Alemán'];
  bool _showPeso = false;
  bool _showImc = false;
  bool _showPgc = false;
  bool _showPmm = false;
  bool _showPecho = false;
  bool _showBiceps = false;
  bool _showCintura = false;
  bool _showMuslo = false;
  bool _showPantorrilla = false;
  //final storage = FlutterSecureStorage();

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  Future<void> _loadData() async {
    final pref = await SharedPreferences.getInstance();
    _showPeso = pref.getBool('showPeso') ?? false;
    /* _showImc = (await storage.read(key: 'showImc')) == 'true';
    _showPgc = (await storage.read(key: 'showPgc')) == 'true';
    _showPmm = (await storage.read(key: 'showPmm')) == 'true';
    _showPecho = (await storage.read(key: 'showPecho')) == 'true';
    _showBiceps = (await storage.read(key: 'showBiceps')) == 'true';
    _showCintura = (await storage.read(key: 'showCintura')) == 'true';
    _showMuslo = (await storage.read(key: 'showMuslo')) == 'true';
    _showPantorrilla = (await storage.read(key: 'showPantorrilla')) == 'true'; */
  }

  Future<void> _savePeso() async {
    //await storage.write(key: 'showPeso', value: _showPeso.toString());
  }

  Future<void> _saveImc() async {
    //await storage.write(key: 'showImc', value: _showImc.toString());
  }

  Future<void> _savePgc() async {
    //await storage.write(key: 'showPgc', value: _showPgc.toString());
  }

  Future<void> _savePmm() async {
    // await storage.write(key: 'showPmm', value: _showPmm.toString());
  }

  Future<void> _savePecho() async {
    //storage.write(key: 'showPecho', value: _showPecho.toString());
  }

  Future<void> _saveBiceps() async {
    // await storage.write(key: 'showBiceps', value: _showBiceps.toString());
  }

  Future<void> _saveCintura() async {
    //await storage.write(key: 'showCintura', value: _showCintura.toString());
  }

  Future<void> _saveMuslo() async {
    //await storage.write(key: 'showMuslo', value: _showMuslo.toString());
  }

  Future<void> _savePantorrilla() async {
    //await storage.write(
    //key: 'showPantorrilla', value: _showPantorrilla.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Configuración',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 16,
          ),
          ListTile(
            title: const Text('Idioma'),
            subtitle: const Text('Cambiar idioma'),
            leading: const Icon(Icons.language),
            trailing: DropdownButton<String>(
              hint: const Text('Idioma'),
              value: _selectedLanguage,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLanguage = newValue!;
                });
              },
              items: _languages.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text('Gráficos'),
          ),
          ListTile(
            title: const Text('Peso'),
            subtitle: const Text('Progreso de peso corporal'),
            leading: const Iconify(
              GameIcons.weight_scale,
              color: Colors.black54,
            ),
            trailing: Switch(
              value: _showPeso,
              onChanged: (bool value) {
                setState(() {
                  _showPeso = value;
                });
                _savePeso();
              },
              activeColor: Colors.blue.shade800,
              activeTrackColor: Colors.blue.shade400,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey.withOpacity(0.5),
            ),
          ),
          ListTile(
            title: const Text('IMC'),
            subtitle: const Text('Indice de masa corporal'),
            leading: const Iconify(
              Healthicons.overweight,
              color: Colors.black54,
            ),
            trailing: Switch(
              value: _showImc,
              onChanged: (bool value) {
                setState(() {
                  _showImc = value;
                });
                _saveImc();
              },
              activeColor: Colors.blue.shade800,
              activeTrackColor: Colors.blue.shade400,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey.withOpacity(0.5),
            ),
          ),
          ListTile(
            title: const Text('PGC'),
            subtitle: const Text('Porciento de grasa corporal'),
            leading: const Iconify(
              GameIcons.fat,
              color: Colors.black54,
            ),
            trailing: Switch(
              value: _showPgc,
              onChanged: (bool value) {
                setState(() {
                  _showPgc = value;
                });
                _savePgc();
              },
              activeColor: Colors.blue.shade800,
              activeTrackColor: Colors.blue.shade400,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey.withOpacity(0.5),
            ),
          ),
          ListTile(
            title: Row(
              children: [
                const Text('PMM '),
                Icon(
                  Icons.workspace_premium,
                  color: Colors.yellow.shade800,
                )
              ],
            ),
            subtitle: const Text('Porciento de músculo magro'),
            leading: const Iconify(
              GameIcons.muscle_up,
              color: Colors.black54,
            ),
            trailing: Switch(
              value: _showPmm,
              onChanged: (bool value) {
                setState(() {
                  _showPmm = value;
                });
                _savePmm();
              },
              activeColor: Colors.blue.shade800,
              activeTrackColor: Colors.blue.shade400,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey.withOpacity(0.5),
            ),
          ),
          ListTile(
            title: Row(
              children: [
                const Text('Pecho '),
                Icon(
                  Icons.workspace_premium,
                  color: Colors.yellow.shade800,
                )
              ],
            ),
            subtitle: const Text('Progreso de pecho'),
            leading: const Iconify(
              IconParkOutline.chest,
              color: Colors.black54,
            ),
            trailing: Switch(
              value: _showPecho,
              onChanged: (bool value) {
                setState(() {
                  _showPecho = value;
                });
                _savePecho();
              },
              activeColor: Colors.blue.shade800,
              activeTrackColor: Colors.blue.shade400,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey.withOpacity(0.5),
            ),
          ),
          ListTile(
            title: Row(
              children: [
                const Text('Biceps '),
                Icon(
                  Icons.workspace_premium,
                  color: Colors.yellow.shade800,
                )
              ],
            ),
            subtitle: const Text('Progreso de biceps'),
            leading: const Iconify(
              GameIcons.biceps,
              color: Colors.black54,
            ),
            trailing: Switch(
              value: _showBiceps,
              onChanged: (bool value) {
                setState(() {
                  _showBiceps = value;
                });
                _saveBiceps();
              },
              activeColor: Colors.blue.shade800,
              activeTrackColor: Colors.blue.shade400,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey.withOpacity(0.5),
            ),
          ),
          ListTile(
            title: Row(
              children: [
                const Text('Cintura '),
                Icon(
                  Icons.workspace_premium,
                  color: Colors.yellow.shade800,
                )
              ],
            ),
            subtitle: const Text('Progreso de cintura'),
            leading: const Iconify(
              IconParkOutline.waistline,
              color: Colors.black54,
            ),
            trailing: Switch(
              value: _showCintura,
              onChanged: (bool value) {
                setState(() {
                  _showCintura = value;
                });
                _saveCintura();
              },
              activeColor: Colors.blue.shade800,
              activeTrackColor: Colors.blue.shade400,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey.withOpacity(0.5),
            ),
          ),
          ListTile(
            title: Row(
              children: [
                const Text('Muslo '),
                Icon(
                  Icons.workspace_premium,
                  color: Colors.yellow.shade800,
                )
              ],
            ),
            subtitle: const Text('Progreso de muslo'),
            leading: const Iconify(
              GameIcons.leg,
              color: Colors.black54,
            ),
            trailing: Switch(
              value: _showMuslo,
              onChanged: (bool value) {
                setState(() {
                  _showMuslo = value;
                });
                _saveMuslo();
              },
              activeColor: Colors.blue.shade800,
              activeTrackColor: Colors.blue.shade400,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey.withOpacity(0.5),
            ),
          ),
          ListTile(
            title: Row(
              children: [
                const Text('Pantorrilla '),
                Icon(
                  Icons.workspace_premium,
                  color: Colors.yellow.shade800,
                )
              ],
            ),
            subtitle: const Text('Progreso de pantorrilla'),
            leading: const Iconify(
              Healthicons.leg,
              color: Colors.black54,
            ),
            trailing: Switch(
              value: _showPantorrilla,
              onChanged: (bool value) {
                setState(() {
                  _showPantorrilla = value;
                });
                _savePantorrilla();
              },
              activeColor: Colors.blue.shade800,
              activeTrackColor: Colors.blue.shade400,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey.withOpacity(0.5),
            ),
          )
        ],
      ),
    );
  }
}
