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

  void loadLastMeasure() async {
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
          showSnackBar(context, 'Medidas guardadas');
        } else {
          showSnackBar(context, 'Error al guardar');
        }
      }
    } else {
      showSnackBar(context, 'Error al guardar');
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
        showSnackBar(context, 'Medidas guardadas');
      } else {
        showSnackBar(context, 'Error al guardar guardadas');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Medidas Personales',
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
                        title: const Text('Confirmar adición'),
                        content: const Text(
                            'Se creará un nuevo registro de medidas personales'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pop(false); // Cerrar y devolver false
                            },
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pop(true); // Cerrar y devolver verdadero
                            },
                            child: const Text('Aceptar'),
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
                  const Text('Información Personal'),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: edadController,
                          decoration:
                              const InputDecoration(labelText: 'Edad *'),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese valor de edad';
                            }
                            if (int.parse(value) > 100 ||
                                int.parse(value) < 10) {
                              return 'Valor de edad no válido';
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
                              return 'Seleccione el sexo';
                            } else {
                              return null;
                            }
                          },
                          hint: const Text("Sexo *"),
                          onChanged: (String? newValue) {
                            setState(() {
                              sexoSelected = newValue;
                            });
                          },
                          items: ['Hombre', 'Mujer']
                              .map<DropdownMenuItem<String>>((String sexo) {
                            return DropdownMenuItem<String>(
                              value: sexo,
                              child: Text(sexo),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  DropdownButtonFormField<int>(
                    value: objetivoSelected,
                    validator: (value) {
                      if (value == null) {
                        return 'Seleccione el objetivo';
                      } else {
                        return null;
                      }
                    },
                    hint: const Text("Objetivo *"),
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
                        return 'Seleccione el nivel de actividad física';
                      } else {
                        return null;
                      }
                    },
                    hint: const Text(
                      "Nivel de actividad física *",
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
                  const Text('Medidas Personales'),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: estaturaController,
                          decoration:
                              const InputDecoration(labelText: 'Estatura cm*'),
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: false, decimal: true),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}')),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese valor de estatura';
                            }
                            if (double.parse(value) > 250 ||
                                double.parse(value) < 50) {
                              return 'Valor de estatura no válido';
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
                          decoration:
                              const InputDecoration(labelText: 'Peso kg *'),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}')),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese valor de peso';
                            }
                            if (double.parse(value) > 600 ||
                                double.parse(value) < 30) {
                              return 'valor de peso no válido';
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
                          decoration:
                              const InputDecoration(labelText: 'Cintura cm *'),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}')),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese valor de cintura';
                            }
                            if (double.parse(value) > 200 ||
                                double.parse(value) < 30) {
                              return 'Valor de cintura no válido';
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
                          decoration: const InputDecoration(
                              labelText: 'Cadera cm (Mujer)'),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}')),
                          ],
                          validator: (value) {
                            if (sexoSelected != null &&
                                sexoSelected == "Mujer" &&
                                (value == null || value.isEmpty)) {
                              return 'Ingrese valor de cadera';
                            }

                            if (value!.isNotEmpty &&
                                double.parse(value) > 0 &&
                                (double.parse(value) > 400 ||
                                    double.parse(value) < 40)) {
                              return 'Valor de cadera no válido';
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
                          decoration:
                              const InputDecoration(labelText: 'Cuello cm *'),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}')),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese valor del cuello';
                            }
                            if (double.parse(value) > 200 ||
                                double.parse(value) < 15) {
                              return 'Valor de cuello no válido';
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
                          decoration:
                              const InputDecoration(labelText: 'Muñeca cm*'),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}')),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese valor de muñeca';
                            }
                            if (double.parse(value) > 40 ||
                                double.parse(value) < 5) {
                              return 'Valor de muñeca no válido';
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
                          decoration:
                              const InputDecoration(labelText: 'Tobillo cm*'),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}')),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese valor de tobillo';
                            }
                            if (double.parse(value) > 60 ||
                                double.parse(value) < 5) {
                              return 'Valor de tobillo no válido';
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
                          decoration:
                              const InputDecoration(labelText: 'Pecho cm *'),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}')),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese valor de pecho';
                            }
                            if (double.parse(value) > 250 ||
                                double.parse(value) < 40) {
                              return 'Valor de pecho no válido';
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
                          decoration:
                              const InputDecoration(labelText: 'Biceps cm *'),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}')),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese valor de biceps';
                            }
                            if (double.parse(value) > 200 ||
                                double.parse(value) < 10) {
                              return 'Valor de biceps no válido';
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
                          decoration: const InputDecoration(
                              labelText: 'Antebrazo cm *'),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}')),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese valor de antebrazo';
                            }
                            if (double.parse(value) > 150 ||
                                double.parse(value) < 10) {
                              return 'Valor de antebrazo no válido';
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
                          decoration:
                              const InputDecoration(labelText: 'Muslo cm *'),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}')),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese valor de muslo';
                            }
                            if (double.parse(value) > 200 ||
                                double.parse(value) < 30) {
                              return 'Valor de muslo no válido';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: pantorrillaController,
                    decoration:
                        const InputDecoration(labelText: 'Gemelos cm *'),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}')),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese valor de gemelos';
                      }
                      if (double.parse(value) > 100 ||
                          double.parse(value) < 10) {
                        return 'Valor de gemelos no válido';
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
