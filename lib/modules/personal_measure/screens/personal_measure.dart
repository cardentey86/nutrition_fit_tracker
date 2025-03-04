import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nutrition_fit_traker/modules/personal_measure/models/nivel_actividad.dart';

class MedidasPersonales extends StatefulWidget {
  const MedidasPersonales({super.key});

  @override
  State<MedidasPersonales> createState() => _MedidasPersonalesState();
}

class _MedidasPersonalesState extends State<MedidasPersonales> {
  bool isMenuOpen = false;
  final _formKey = GlobalKey<FormState>();
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

  void toggleMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
    });
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
                onPressed: () {
                  showSnackBar(context, 'Add new');
                  toggleMenu();
                }),
            const SizedBox(
              height: 10,
            ),
            _buildMenuBotton(
                index: 1,
                icon: Icons.save,
                onPressed: () {
                  showSnackBar(context, 'Save change');
                  toggleMenu();
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
                              return 'Ingrese la edad';
                            }
                            if (int.parse(value) > 100 ||
                                int.parse(value) < 10) {
                              return 'Edad no valida';
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
                    value: objetivoSelected,
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
                        objetivoSelected = newValue;
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
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese la estatura';
                            }
                            if (int.parse(value) > 250 ||
                                int.parse(value) < 100) {
                              return 'Estatura no valida';
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
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese el peso';
                            }
                            if (int.parse(value) > 400 ||
                                int.parse(value) < 40) {
                              return 'Peso no valido';
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
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese la cintura';
                            }
                            if (int.parse(value) > 200 ||
                                int.parse(value) < 50) {
                              return 'Cintura no válida';
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
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            if (sexoSelected == "Mujer" &&
                                (value == null || value.isEmpty)) {
                              return 'Ingrese el cadera';
                            }
                            if (int.parse(value!) > 400 ||
                                int.parse(value) < 40) {
                              return 'Peso no valido';
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
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese valor del cuello';
                            }
                            if (int.parse(value) > 150 ||
                                int.parse(value) < 20) {
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
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese valor de muñeca';
                            }
                            if (int.parse(value) > 30 || int.parse(value) < 5) {
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
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese valor de tobillo';
                            }
                            if (int.parse(value) > 30 || int.parse(value) < 5) {
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
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese valor de pecho';
                            }
                            if (int.parse(value) > 200 ||
                                int.parse(value) < 50) {
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
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese valor de biceps';
                            }
                            if (int.parse(value) > 200 ||
                                int.parse(value) < 50) {
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
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese valor de antebrazo';
                            }
                            if (int.parse(value) > 80 ||
                                int.parse(value) < 10) {
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
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese valor de muslo';
                            }
                            if (int.parse(value) > 200 ||
                                int.parse(value) < 30) {
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
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese valor de gemelos';
                      }
                      if (int.parse(value) > 100 || int.parse(value) < 10) {
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
