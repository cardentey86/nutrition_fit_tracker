import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nutrition_fit_traker/modules/personal_measure/infrastructure/personal_measure_controller.dart';
import 'package:nutrition_fit_traker/modules/personal_measure/models/measure_model.dart';
import 'package:nutrition_fit_traker/modules/personal_measure/models/nivel_actividad.dart';
import 'package:nutrition_fit_traker/modules/personal_measure/models/objetivo.dart';

class MedidasPersonales extends StatefulWidget {
  const MedidasPersonales({super.key});

  @override
  State<MedidasPersonales> createState() => _MedidasPersonalesState();
}

class _MedidasPersonalesState extends State<MedidasPersonales> {
  bool isMenuOpen = false;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  PersonalMeasure? personalMeasure;
  final PersonalMeasureController _personalMeasureController =
      PersonalMeasureController();

  String? sexoSelected;
  int? nivelActividadSelected;
  int? objetivoSelected;
  final edadController = TextEditingController();
  final estaturaController = TextEditingController();
  final pesoController = TextEditingController();
  final cinturaController = TextEditingController();
  final caderaController = TextEditingController();
  final cuelloController = TextEditingController();
  final munecaController = TextEditingController();
  final tobilloController = TextEditingController();
  final pechoController = TextEditingController();
  final bicepsController = TextEditingController();
  final antebrazoController = TextEditingController();
  final musloController = TextEditingController();
  final pantorrillaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadLastMeasure();
  }

  void toggleMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
    });
  }

  Future<void> loadLastMeasure() async {
    setState(() {
      _isLoading = true;
    });
    final result = await _personalMeasureController.getLast();
    setState(() {
      personalMeasure = result;

      if (personalMeasure != null) {
        sexoSelected = personalMeasure!.sexo;
        objetivoSelected = personalMeasure!.objetivo;
        nivelActividadSelected = personalMeasure!.nivelActividad;

        edadController.text = personalMeasure!.edad.toString();
        estaturaController.text = personalMeasure!.estatura.toString();
        pesoController.text = personalMeasure!.peso.toString();
        cinturaController.text = personalMeasure!.cintura.toString();
        caderaController.text = personalMeasure!.cadera.toString();
        cuelloController.text = personalMeasure!.cuello.toString();
        munecaController.text = personalMeasure!.muneca.toString();

        tobilloController.text = personalMeasure!.tobillo.toString();
        pechoController.text = personalMeasure!.pecho.toString();
        bicepsController.text = personalMeasure!.biceps.toString();
        antebrazoController.text = personalMeasure!.antebrazo.toString();
        musloController.text = personalMeasure!.muslo.toString();
        pantorrillaController.text = personalMeasure!.gemelos.toString();
      }
    });
    setState(() {
      _isLoading = false;
    });
  }

  void saveMeasure() async {
    if (personalMeasure != null &&
        personalMeasure!.id != null &&
        personalMeasure!.id! > 0) {
      setState(() {
        personalMeasure!.sexo = sexoSelected!;
        personalMeasure!.objetivo = objetivoSelected!;
        personalMeasure!.nivelActividad = nivelActividadSelected!;
        personalMeasure!.edad = int.parse(edadController.text);
        personalMeasure!.estatura = double.parse(estaturaController.text);
        personalMeasure!.peso = double.parse(pesoController.text);
        personalMeasure!.cintura = double.parse(cinturaController.text);
        personalMeasure!.cadera = double.parse(caderaController.text);
        personalMeasure!.cuello = double.parse(cuelloController.text);
        personalMeasure!.muneca = double.parse(munecaController.text);
        personalMeasure!.tobillo = double.parse(tobilloController.text);
        personalMeasure!.pecho = double.parse(pechoController.text);
        personalMeasure!.biceps = double.parse(bicepsController.text);
        personalMeasure!.antebrazo = double.parse(antebrazoController.text);
        personalMeasure!.muslo = double.parse(musloController.text);
        personalMeasure!.gemelos = double.parse(pantorrillaController.text);
      });

      final result = await _personalMeasureController.update(personalMeasure!);

      if (mounted) {
        if (result) {
          showSnackBar(context, 'personalMeasure.saved'.tr());
        } else {
          showSnackBar(context, 'personalMeasure.errorSaved'.tr());
        }
      }
    } else {
      showSnackBar(context, 'personalMeasure.errorSaved'.tr());
    }
  }

  Future<void> addNewMeasure() async {
    PersonalMeasure measure = PersonalMeasure(
        id: null,
        fecha: DateTime.now().toString(),
        edad: int.parse(edadController.text),
        sexo: sexoSelected!,
        objetivo: objetivoSelected!,
        nivelActividad: nivelActividadSelected!,
        estatura: double.parse(estaturaController.text),
        peso: double.parse(pesoController.text),
        cintura: double.parse(cinturaController.text),
        cadera: caderaController.text.isEmpty
            ? 0
            : double.parse(caderaController.text),
        cuello: double.parse(cuelloController.text),
        muneca: double.parse(munecaController.text),
        tobillo: double.parse(tobilloController.text),
        pecho: double.parse(pechoController.text),
        biceps: double.parse(bicepsController.text),
        antebrazo: double.parse(antebrazoController.text),
        muslo: double.parse(musloController.text),
        gemelos: double.parse(pantorrillaController.text));

    var result = await _personalMeasureController.insert(measure);

    if (mounted) {
      if (result) {
        showSnackBar(context, 'personalMeasure.saved'.tr());
      } else {
        showSnackBar(context, 'personalMeasure.errorSaved'.tr());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'personalMeasure.title'.tr(),
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isMenuOpen) ...[
            _buildMenuBotton(
                icon: Icons.add,
                index: 0,
                onPressed: () async {
                  final shouldAdd = await showDialog<bool>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('personalMeasure.addConfirmTitle'.tr()),
                        content: Text('personalMeasure.addConfirmDesc'.tr()),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pop(false); // Cerrar y devolver false
                            },
                            child: Text('personalMeasure.btnCancel'.tr()),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pop(true); // Cerrar y devolver verdadero
                            },
                            child: Text('personalMeasure.btnOk'.tr()),
                          ),
                        ],
                      );
                    },
                  );

                  if (shouldAdd != null && shouldAdd) {
                    if (_formKey.currentState?.validate() == true) {
                      addNewMeasure();
                    }
                  }
                  toggleMenu();
                }),
            const SizedBox(
              height: 10,
            ),
            _buildMenuBotton(
                index: 1,
                icon: Icons.save,
                onPressed: () {
                  if (_formKey.currentState?.validate() == true) {
                    saveMeasure();
                    toggleMenu();
                  }
                }),
            const SizedBox(
              height: 10,
            ),
          ],
          FloatingActionButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0)),
            onPressed: toggleMenu,
            mini: isMenuOpen,
            backgroundColor: isMenuOpen ? Colors.red : Colors.blue,
            foregroundColor: Colors.white,
            elevation: 4,
            child: Icon(
              isMenuOpen ? Icons.close : Icons.menu,
              key: ValueKey<bool>(isMenuOpen),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Text('personalMeasure.personalInfo'.tr()),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: edadController,
                          decoration: InputDecoration(
                              labelText:
                                  '${'personalMeasure.age.title'.tr()} *'),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'personalMeasure.age.error1'.tr();
                            }
                            if (int.parse(value) > 100 ||
                                int.parse(value) < 10) {
                              return 'personalMeasure.age.error2'.tr();
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        flex: 1,
                        child: DropdownButtonFormField<String>(
                          value: sexoSelected,
                          validator: (value) {
                            if (value == null) {
                              return 'personalMeasure.sex.error1'.tr();
                            } else {
                              return null;
                            }
                          },
                          hint: Text("${'personalMeasure.sex.title'.tr()} *"),
                          onChanged: (String? newValue) {
                            setState(() {
                              sexoSelected = newValue;
                            });
                          },
                          items: [
                            DropdownMenuItem<String>(
                              value: 'Hombre',
                              child: Text('personalMeasure.sex.men'.tr()),
                            ),
                            DropdownMenuItem<String>(
                              value: 'Mujer',
                              child: Text('personalMeasure.sex.woman'.tr()),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  DropdownButtonFormField<int>(
                    value: objetivoSelected,
                    validator: (value) {
                      if (value == null) {
                        return 'personalMeasure.obj.error1'.tr();
                      } else {
                        return null;
                      }
                    },
                    hint: Text("${'personalMeasure.obj.title'.tr()} *"),
                    onChanged: (int? newValue) {
                      setState(() {
                        objetivoSelected = newValue;
                      });
                    },
                    items: Objetivo()
                        .objetivos()
                        .map<DropdownMenuItem<int>>((Objetivo obj) {
                      return DropdownMenuItem<int>(
                        value: obj.id,
                        child: Text(obj.name,
                            style: const TextStyle(fontSize: 14)),
                      );
                    }).toList(),
                  ),
                  DropdownButtonFormField<int>(
                    value: nivelActividadSelected,
                    validator: (value) {
                      if (value == null) {
                        return 'personalMeasure.level.error1'.tr();
                      } else {
                        return null;
                      }
                    },
                    hint: Text(
                      "${'personalMeasure.level.title'.tr()} *",
                    ),
                    onChanged: (int? newValue) {
                      setState(() {
                        nivelActividadSelected = newValue;
                      });
                    },
                    items: NivelActividad()
                        .nivelesActividad()
                        .map<DropdownMenuItem<int>>((NivelActividad nivel) {
                      return DropdownMenuItem<int>(
                        value: nivel.id,
                        child: Text(
                          nivel.name,
                          style: const TextStyle(fontSize: 13),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Text('personalMeasure.measure'.tr()),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: estaturaController,
                          decoration: InputDecoration(
                              labelText: '${'general.body.height'.tr()} cm*'),
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: false, decimal: true),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}')),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'personalMeasure.errors.height1'.tr();
                            }
                            if (double.parse(value) > 250 ||
                                double.parse(value) < 50) {
                              return 'personalMeasure.errors.height2'.tr();
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: pesoController,
                          decoration: InputDecoration(
                              labelText: '${'general.body.weight'.tr()} kg *'),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}')),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'personalMeasure.errors.weight1'.tr();
                            }
                            if (double.parse(value) > 600 ||
                                double.parse(value) < 30) {
                              return 'personalMeasure.errors.weight2'.tr();
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: cinturaController,
                          decoration: InputDecoration(
                              labelText: '${'general.body.waist'.tr()} cm *'),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}')),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'personalMeasure.errors.waist1'.tr();
                            }
                            if (double.parse(value) > 200 ||
                                double.parse(value) < 30) {
                              return 'personalMeasure.errors.waist2'.tr();
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: caderaController,
                          decoration: InputDecoration(
                              labelText:
                                  '${'general.body.hip'.tr()} cm (${'personalMeasure.sex.woman'.tr()})'),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}')),
                          ],
                          validator: (value) {
                            if (sexoSelected != null &&
                                sexoSelected == "Mujer" &&
                                (value == null || value.isEmpty)) {
                              return 'personalMeasure.errors.hip1'.tr();
                            }

                            if (value!.isNotEmpty &&
                                double.parse(value) > 0 &&
                                (double.parse(value) > 400 ||
                                    double.parse(value) < 40)) {
                              return 'personalMeasure.errors.hip2'.tr();
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: cuelloController,
                          decoration: InputDecoration(
                              labelText: '${'general.body.neck'.tr()} cm *'),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}')),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'personalMeasure.errors.neck1'.tr();
                            }
                            if (double.parse(value) > 200 ||
                                double.parse(value) < 15) {
                              return 'personalMeasure.errors.neck2'.tr();
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: munecaController,
                          decoration: InputDecoration(
                              labelText: '${'general.body.wrist'.tr()} cm*'),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}')),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'personalMeasure.errors.wrist1'.tr();
                            }
                            if (double.parse(value) > 40 ||
                                double.parse(value) < 5) {
                              return 'personalMeasure.errors.wrist2'.tr();
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: tobilloController,
                          decoration: InputDecoration(
                              labelText: '${'general.body.ankle'.tr()} cm*'),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}')),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'personalMeasure.errors.ankle1'.tr();
                            }
                            if (double.parse(value) > 60 ||
                                double.parse(value) < 5) {
                              return 'personalMeasure.errors.ankle2'.tr();
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: pechoController,
                          decoration: InputDecoration(
                              labelText: '${'general.body.chest'.tr()} cm *'),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}')),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'personalMeasure.errors.chest1'.tr();
                            }
                            if (double.parse(value) > 250 ||
                                double.parse(value) < 40) {
                              return 'personalMeasure.errors.chest2'.tr();
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: bicepsController,
                          decoration: InputDecoration(
                              labelText: '${'general.body.biceps'.tr()} cm *'),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}')),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'personalMeasure.errors.bicep1'.tr();
                            }
                            if (double.parse(value) > 200 ||
                                double.parse(value) < 10) {
                              return 'personalMeasure.errors.bicep2'.tr();
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: antebrazoController,
                          decoration: InputDecoration(
                              labelText: '${'general.body.forearm'.tr()} cm *'),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}')),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'personalMeasure.errors.forearm1'.tr();
                            }
                            if (double.parse(value) > 150 ||
                                double.parse(value) < 10) {
                              return 'personalMeasure.errors.forearm2'.tr();
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: musloController,
                          decoration: InputDecoration(
                              labelText: '${'general.body.thigh'.tr()} cm *'),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}')),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'personalMeasure.errors.thigh1'.tr();
                            }
                            if (double.parse(value) > 200 ||
                                double.parse(value) < 30) {
                              return 'personalMeasure.errors.thigh2'.tr();
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: pantorrillaController,
                    decoration: InputDecoration(
                        labelText: '${'general.body.calf'.tr()} cm *'),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}')),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'personalMeasure.errors.calf1'.tr();
                      }
                      if (double.parse(value) > 100 ||
                          double.parse(value) < 10) {
                        return 'personalMeasure.errors.calf2'.tr();
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          if (isMenuOpen)
            Container(
              width: double.maxFinite,
              height: double.maxFinite,
              color: Colors.white.withOpacity(0.7),
            ),
        ],
      ),
    );
  }

  Widget _buildMenuBotton(
      {required IconData icon,
      required VoidCallback onPressed,
      required int index}) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: isMenuOpen ? 1 : 0),
      duration: const Duration(milliseconds: 100),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 1 - value) * 60 * (index + 1),
            child: FloatingActionButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0)),
              onPressed: onPressed,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              mini: true,
              elevation: 4,
              child: Icon(icon),
            ),
          ),
        );
      },
    );
  }

  void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }
}
