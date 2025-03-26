import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/game_icons.dart';
import 'package:iconify_flutter/icons/healthicons.dart';
import 'package:iconify_flutter/icons/icon_park_outline.dart';
import 'package:nutrition_fit_traker/modules/configuration/models/languaje_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({super.key});

  @override
  State<ConfigScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ConfigScreen> {
  String? _selectedLanguage;
  final List<Languajes> _languages = Languajes.getLanguajes();
  bool _showPeso = false;
  bool _showImc = false;
  bool _showPgc = false;
  bool _showPmm = false;
  bool _showPecho = false;
  bool _showBiceps = false;
  bool _showCintura = false;
  bool _showMuslo = false;
  bool _showPantorrilla = false;

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  Future<void> _loadData() async {
    final pref = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _showPeso = pref.getBool('showPeso') ?? false;
      _showImc = pref.getBool('showImc') ?? false;
      _showPgc = pref.getBool('showPgc') ?? false;
      _showPmm = pref.getBool('showPmm') ?? false;
      _showPecho = pref.getBool('showPecho') ?? false;
      _showBiceps = pref.getBool('showBiceps') ?? false;
      _showCintura = pref.getBool('showCintura') ?? false;
      _showMuslo = pref.getBool('showMuslo') ?? false;
      _showPantorrilla = pref.getBool('showPantorrilla') ?? false;
      _selectedLanguage = pref.getString('globalization');
      if (_selectedLanguage != null) {
        context.setLocale(Locale(_selectedLanguage!));
      }
    });
  }

  void _saveLanguaje(BuildContext context) async {
    SharedPreferences.getInstance().then(
        (onValue) => onValue.setString('globalization', _selectedLanguage!));
    context.setLocale(Locale(_selectedLanguage!));
  }

  Future<void> _savePeso() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool('showPeso', _showPeso);
  }

  Future<void> _saveImc() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool('showImc', _showImc);
  }

  Future<void> _savePgc() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool('showPgc', _showPgc);
  }

  Future<void> _savePmm() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool('showPmm', _showPmm);
  }

  Future<void> _savePecho() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool('showPecho', _showPecho);
  }

  Future<void> _saveBiceps() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool('showBiceps', _showBiceps);
  }

  Future<void> _saveCintura() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool('showCintura', _showCintura);
  }

  Future<void> _saveMuslo() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool('showMuslo', _showMuslo);
  }

  Future<void> _savePantorrilla() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool('showPantorrilla', _showPantorrilla);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'configuration.title'.tr(),
          style: const TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 16,
          ),
          ListTile(
            title: Text('configuration.language'.tr()),
            subtitle: Text('configuration.changeLanguage'.tr()),
            leading: const Icon(Icons.language),
            trailing: DropdownButton<String>(
              hint: Text('configuration.language'.tr()),
              value: _selectedLanguage,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLanguage = newValue!;
                });
                _saveLanguaje(context);
              },
              items:
                  _languages.map<DropdownMenuItem<String>>((Languajes value) {
                return DropdownMenuItem<String>(
                  value: value.code,
                  child: Text(value.languaje),
                );
              }).toList(),
            ),
          ),
          const Divider(),
          Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text('configuration.charts'.tr()),
          ),
          ListTile(
            title: Text('configuration.weight'.tr()),
            subtitle: Text('configuration.progressWeight'.tr()),
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
              activeColor: Colors.white,
              activeTrackColor: Colors.blue,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey.withValues(alpha: 0.5),
            ),
          ),
          ListTile(
            title: Text('configuration.imc'.tr()),
            subtitle: Text('configuration.progressImc'.tr()),
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
              activeColor: Colors.white,
              activeTrackColor: Colors.blue,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey.withOpacity(0.5),
            ),
          ),
          ListTile(
            title: Text('configuration.pgc'.tr()),
            subtitle: Text('configuration.progressPgc'.tr()),
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
              activeColor: Colors.white,
              activeTrackColor: Colors.blue,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey.withOpacity(0.5),
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Text('configuration.pmm'.tr()),
              ],
            ),
            subtitle: Text('configuration.progressPmm'.tr()),
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
              activeColor: Colors.white,
              activeTrackColor: Colors.blue,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey.withOpacity(0.5),
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Text('configuration.chest'.tr()),
              ],
            ),
            subtitle: Text('configuration.progressChest'.tr()),
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
              activeColor: Colors.white,
              activeTrackColor: Colors.blue,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey.withOpacity(0.5),
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Text('configuration.biceps'.tr()),
              ],
            ),
            subtitle: Text('configuration.progressBiceps'.tr()),
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
              activeColor: Colors.white,
              activeTrackColor: Colors.blue,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey.withOpacity(0.5),
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Text('configuration.waist'.tr()),
              ],
            ),
            subtitle: Text('configuration.progressWaist'.tr()),
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
              activeColor: Colors.white,
              activeTrackColor: Colors.blue,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey.withOpacity(0.5),
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Text('configuration.thigh'.tr()),
              ],
            ),
            subtitle: Text('configuration.progressThigh'.tr()),
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
              activeColor: Colors.white,
              activeTrackColor: Colors.blue,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey.withOpacity(0.5),
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Text('configuration.calf'.tr()),
              ],
            ),
            subtitle: Text('configuration.progressCalf'.tr()),
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
              activeColor: Colors.white,
              activeTrackColor: Colors.blue,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey.withOpacity(0.5),
            ),
          )
        ],
      ),
    );
  }
}
