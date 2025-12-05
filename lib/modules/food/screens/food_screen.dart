import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:nutrition_fit_traker/modules/food/infrastructure/food_controller.dart';
import 'package:nutrition_fit_traker/modules/food/models/food_model.dart';
import 'package:nutrition_fit_traker/modules/menu/infrastructure/menu_plato_controller.dart';
import 'package:nutrition_fit_traker/modules/menu/models/menu.dart';
import 'package:nutrition_fit_traker/modules/menu/models/menu_plato.dart';
import 'package:nutrition_fit_traker/modules/menu/screens/menu_plato_dialog.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

List<String> _orderOptions = ['asc', 'desc'];

class _FoodScreenState extends State<FoodScreen> {
  final FoodController _foodController = FoodController();
  final MenuPlatoController _menuPlatoController = MenuPlatoController();
  List<Menu> menus = [];
  List<MenuPlato> menuPlato = [];

  List<Alimento> _alimentos = [];
  List<Alimento> _filteredAlimentos = [];
  final TextEditingController _searchController = TextEditingController();
  String _filter = "";
  bool isLoading = false;
  List<Slidable> _items = [];
  String currentOrderOption = _orderOptions[0];
  final List<DropdownMenuItem> _orderFields = [
    DropdownMenuItem(value: 'nombre', child: Text('foodScreen.name'.tr())),
    DropdownMenuItem(
        value: 'proteina', child: Text('general.macro.proteins'.tr())),
    DropdownMenuItem(
        value: 'carbohidratos', child: Text('general.macro.carbo'.tr())),
    DropdownMenuItem(value: 'grasas', child: Text('general.macro.fats'.tr())),
    DropdownMenuItem(value: 'fibra', child: Text('general.macro.fiber'.tr())),
    DropdownMenuItem(
        value: 'calorias', child: Text('general.macro.calory'.tr()))
  ];
  String orderSelectedField = 'nombre';
  final _formKey = GlobalKey<FormState>();
  Alimento? alimentoToUpdate;
  Alimento? alimentoToAdd;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isLoading) {
      _loadAlimentos();
    }
  }

  Future<void> _loadAlimentos() async {
    setState(() {
      isLoading = true;
    });

    try {
      List<Alimento> alimentos =
      await _foodController.getAlimentos(context.locale.languageCode);

      final resultMenu =
      await _menuPlatoController.getAllMenu(context.locale.languageCode);
      menus = [...resultMenu];

      final resultMenuPlato = await _menuPlatoController.getAllMenuPlato();
      menuPlato = [...resultMenuPlato];

      _alimentos = alimentos;
      _filteredAlimentos = [..._alimentos];
    } finally {
      setState(() {
        isLoading = false;
        _items = _filteredAlimentos
            .map((alimento) => _buildSlidable(alimento))
            .toList();
      });
    }
  }

  Slidable _buildSlidable(Alimento alimento) {
    return Slidable(
      key: Key(alimento.id.toString()),
      startActionPane: ActionPane(
        extentRatio: 0.4,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            spacing: 2,
            backgroundColor: Colors.transparent,
            padding: const EdgeInsets.all(8.0),
            label: "Edit",
            foregroundColor: Colors.blue,
            icon: Icons.edit,
            onPressed: (context) async {
              setState(() {
                alimentoToUpdate = alimento;
              });
              await _formAlimento('update');
            },
          ),
          SlidableAction(
            spacing: 2,
            padding: const EdgeInsets.all(8.0),
            backgroundColor: Colors.transparent,
            label: "Add Menú",
            foregroundColor: Colors.green,
            icon: Icons.add_box,
            onPressed: (context) {
              setState(() {
                alimentoToAdd = alimento;
              });
              _showAlimentoDialog('add', null, null, alimento.id.toString());
            },
          )
        ],
      ),
      endActionPane: ActionPane(
        extentRatio: 0.2,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            spacing: 2,
            padding: const EdgeInsets.all(8.0),
            label: "foodScreen.delete".tr(),
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.red,
            icon: Icons.delete,
            onPressed: (context) async {
              final shouldDelete = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("foodScreen.deleteConfirm".tr()),
                  content: Text('foodScreen.deleteConfirm'
                      .tr(namedArgs: {'alimento': alimento.nombre})),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text("foodScreen.btnCancel".tr()),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: Text("foodScreen.btnOk".tr()),
                    ),
                  ],
                ),
              );

              if (shouldDelete == true) {
                await _foodController.eliminarAlimento(alimento.id!);
                setState(() {
                  _alimentos.removeWhere((e) => e.id == alimento.id);
                  _filteredAlimentos.removeWhere((e) => e.id == alimento.id);
                  _items = _filteredAlimentos.map(_buildSlidable).toList();
                });
              }
            },
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              alimento.nombre,
              style: const TextStyle(
                color: Colors.black,
                fontStyle: FontStyle.italic,
              ),
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('general.macro.calory'.tr(),
                        style: const TextStyle(color: Colors.grey)),
                    Text('${alimento.calorias} Kcal',
                        style: const TextStyle(color: Colors.black87)),
                  ],
                ),
                Column(
                  children: [
                    Text('general.macro.proteins'.tr(),
                        style: const TextStyle(color: Colors.grey)),
                    Text('${alimento.proteinas}g',
                        style: const TextStyle(color: Colors.black87)),
                  ],
                ),
                Column(
                  children: [
                    Text('general.macro.carbo'.tr(),
                        style: const TextStyle(color: Colors.grey)),
                    Text('${alimento.carbohidratos}g',
                        style: const TextStyle(color: Colors.black87)),
                  ],
                ),
                Column(
                  children: [
                    Text('general.macro.fats'.tr(),
                        style: const TextStyle(color: Colors.grey)),
                    Text('${alimento.grasas}g',
                        style: const TextStyle(color: Colors.black87)),
                  ],
                ),
                Column(
                  children: [
                    Text('general.macro.fiber'.tr(),
                        style: const TextStyle(color: Colors.grey)),
                    Text('${alimento.fibra}g',
                        style: const TextStyle(color: Colors.black87)),
                  ],
                ),
              ],
            ),
          ),
          if (alimento.nombre !=
              _filteredAlimentos[_filteredAlimentos.length - 1].nombre)
            const Divider(color: Colors.blueGrey),
        ],
      ),
    );
  }



  Future<void> insertMenuPlato(
      int idMenu, int idAlimento, double cantidad) async {
    MenuPlato menuPlato = MenuPlato(
        idMenu: idMenu,
        idAlimento: idAlimento,
        fecha: DateTime.now().toString(),
        cantidad: cantidad);
    await _menuPlatoController.insertMenuPlato(menuPlato);
  }

  void _showAlimentoDialog(String action, MenuPlato? menuPlatoToUpdate,
      String? selectedMenu, String? selectedFood) {
    showDialog(
      context: context,
      builder: (context) {
        return AddFoodDialog(
            menuPlato: menuPlatoToUpdate,
            selectedMenu: selectedMenu,
            selectedFood: selectedFood,
            action: action,
            menuNames: menus,
            alimentos: [alimentoToAdd!],
            onAddMenuPlato: (id, selectedMenu, selectedFood, quantity) async {
              var exist = menuPlato.any((item) =>
                  item.idAlimento == selectedFood &&
                  item.idMenu == selectedMenu);
              if (!exist) {
                await insertMenuPlato(selectedMenu, selectedFood, quantity);
                Navigator.pop(context);
              } else {
                showSnackBar(context, 'menuFood.menuScreen.existFood'.tr());
              }
            });
      },
    );
  }

  void setData() {
    setState(() {
      _items = _filteredAlimentos.map(_buildSlidable).toList();
    });
  }


  Future<void> _restartAlimentos() async {
    if (isLoading) return; // ❌ bloquea si ya se está cargando

    // Verifica si hay alimentos en la base de datos
    bool hasAlimentos = await _foodController.any();

    if (hasAlimentos) {
      final confirm = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('foodScreen.updateConfirm'.tr()),
          content: Text('foodScreen.updateQuestion'.tr()),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('foodScreen.btnCancel'.tr())),
            TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text('foodScreen.btnOk'.tr())),
          ],
        ),
      );

      if (confirm != true) return; // ❌ el usuario canceló
    }

    // Si no hay alimentos o el usuario confirmó, reinicia
    await _reiniciarAlimentos();
  }


  Future<void> _reiniciarAlimentos() async {
    if (isLoading) return; // doble chequeo de seguridad
    setState(() => isLoading = true); // muestra indicador de carga

    try {
      bool success = await _foodController.reiniciarAlimentos();
      if (success) {
        await _loadAlimentos(); // recarga los alimentos
        setData(); // actualiza los Slidables
      } else if (mounted) {
        showSnackBar(context, 'foodScreen.errorRestart'.tr());
      }
    } catch (e) {
      if (mounted) {
        showSnackBar(context, 'foodScreen.errorRestart'.tr());
      }
    } finally {
      if (mounted) setState(() => isLoading = false); // oculta indicador
    }
  }

  void _filterAlimentos(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredAlimentos = [..._alimentos];
      });
    } else {
      setState(() {
        _filteredAlimentos = [
          ..._alimentos.where((alimento) =>
              alimento.nombre.toLowerCase().contains(query.toLowerCase()))
        ];
      });
    }
    setData();
  }

  Future<void> _formAlimento(String action) async {
    final nombreController = TextEditingController();
    final caloriasController = TextEditingController();
    final proteinaController = TextEditingController();
    final carbohidratoController = TextEditingController();
    final fibraController = TextEditingController();
    final grasaController = TextEditingController();

    if (action == 'update' && alimentoToUpdate != null) {
      nombreController.text = alimentoToUpdate!.nombre;
      caloriasController.text = alimentoToUpdate!.calorias.toString();
      proteinaController.text = alimentoToUpdate!.proteinas.toString();
      carbohidratoController.text = alimentoToUpdate!.carbohidratos.toString();
      grasaController.text = alimentoToUpdate!.grasas.toString();
      fibraController.text = alimentoToUpdate!.fibra.toString();
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(action == 'add'
              ? 'foodScreen.addFood'.tr()
              : 'foodScreen.updateFood'.tr()),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nombreController,
                  decoration:
                      InputDecoration(labelText: 'foodScreen.name'.tr()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'foodScreen.errorName'.tr();
                    }
                    return null;
                  },
                ),
                TextField(
                  controller: caloriasController,
                  decoration:
                      InputDecoration(labelText: 'general.macro.calory'.tr()),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                TextField(
                  controller: proteinaController,
                  decoration:
                      InputDecoration(labelText: 'general.macro.proteins'.tr()),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                TextField(
                  controller: carbohidratoController,
                  decoration:
                      InputDecoration(labelText: 'general.macro.carbo'.tr()),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                TextField(
                  controller: grasaController,
                  decoration:
                      InputDecoration(labelText: 'general.macro.fats'.tr()),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                TextField(
                  controller: fibraController,
                  decoration:
                      InputDecoration(labelText: 'general.macro.fiber'.tr()),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('foodScreen.btnCancel'.tr()),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(action == 'add'
                  ? 'foodScreen.add'.tr()
                  : 'foodScreen.update'.tr()),
              onPressed: () async {
                if (_formKey.currentState?.validate() == true) {
                  final nombre = nombreController.text;
                  final calorias =
                      double.tryParse(caloriasController.text) ?? 0;
                  final proteinas =
                      double.tryParse(proteinaController.text) ?? 0;
                  final carbohidratos =
                      double.tryParse(carbohidratoController.text) ?? 0;
                  final grasas = double.tryParse(grasaController.text) ?? 0;
                  final fibra = double.tryParse(fibraController.text) ?? 0;

                  Alimento alimento = Alimento(
                    id: alimentoToUpdate?.id,
                    nombre: nombre,
                    calorias: calorias,
                    carbohidratos: carbohidratos,
                    proteinas: proteinas,
                    grasas: grasas,
                    fibra: fibra,
                  );

                  bool result = false;

                  if (action == 'add') {
                    result = await _foodController.insertAlimento(
                        alimento, context.locale.languageCode);
                    if (result) {
                      setState(() {
                        _filteredAlimentos.add(alimento);
                        _alimentos.add(alimento);
                      });
                      setData();
                    }
                  } else {
                    result = await _foodController.updateAlimento(
                        alimento, context.locale.languageCode);
                    await _loadAlimentos();
                  }

                  if (mounted) {
                    Navigator.of(context).pop();
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            'foodScreen.foods'.tr(),
            style: TextStyle(color: Colors.black87),
          ),
          const SizedBox(
            width: 16.0,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'foodScreen.search'.tr(),
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.search, color: Colors.black54),
                ),
                onChanged: (value) {
                  if (value.isEmpty) {
                    setState(() {
                      _filter = "";
                    });
                    _filterAlimentos(_filter);
                  }
                },
                onEditingComplete: () {
                  setState(() {
                    _filter = _searchController.text;
                  });
                  _filterAlimentos(_filter);
                },
              ),
            ),
          ),
        ]),
        backgroundColor: Colors.transparent,
        elevation: 4,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        elevation: 4,
        onPressed: () => _formAlimento('add'),
        child: const Icon(Icons.add),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: _restartAlimentos,
              ),
              const Spacer(),
              Text('${'foodScreen.sortBy'.tr()}:'),
              const SizedBox(
                width: 8,
              ),
              DropdownButton(
                  value: orderSelectedField,
                  icon: currentOrderOption == 'asc'
                      ? const Icon(Icons.keyboard_double_arrow_up)
                      : const Icon(Icons.keyboard_double_arrow_down),
                  items: _orderFields,
                  onChanged: (value) {
                    setState(() {
                      orderSelectedField = value;
                      sortFoods();
                    });
                  }),
              const Spacer(),
              PopupMenuButton<String>(
                onSelected: (String result) {
                  setState(() {
                    currentOrderOption = result;
                    sortFoods();
                  });
                },
                itemBuilder: (BuildContext context) {
                  return _orderOptions.map((String option) {
                    return PopupMenuItem<String>(
                      value: option,
                      child: Text(option == currentOrderOption
                          ? '* $option${'foodScreen.sortFinal'.tr()}'
                          : '$option${'foodScreen.sortFinal'.tr()}'),
                    );
                  }).toList();
                },
              )
            ],
          ),
          const Divider(
            height: 8.0,
          ),
          Expanded(
              child: isLoading
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text('foodScreen.reloading'.tr()),
                        ],
                      ),
                    )
                  : ListView(
                      children: _items,
                    )),
        ],
      ),
    );
  }

  void showSnackBar(BuildContext context, String s) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(s),
    ));
  }

  void sortFoods() {
    setState(() {
      switch (orderSelectedField) {
        case 'nombre':
          if (currentOrderOption == _orderOptions[0]) {
            _filteredAlimentos.sort((a, b) => a.nombre.compareTo(b.nombre));
          } else {
            _filteredAlimentos.sort((a, b) => b.nombre.compareTo(a.nombre));
          }
          break;
        case 'proteina':
          if (currentOrderOption == _orderOptions[0]) {
            _filteredAlimentos
                .sort((a, b) => a.proteinas.compareTo(b.proteinas));
          } else {
            _filteredAlimentos
                .sort((a, b) => b.proteinas.compareTo(a.proteinas));
          }
          break;
        case 'carbohidratos':
          if (currentOrderOption == _orderOptions[0]) {
            _filteredAlimentos
                .sort((a, b) => a.carbohidratos.compareTo(b.carbohidratos));
          } else {
            _filteredAlimentos
                .sort((a, b) => b.carbohidratos.compareTo(a.carbohidratos));
          }
          break;
        case 'grasas':
          if (currentOrderOption == _orderOptions[0]) {
            _filteredAlimentos.sort((a, b) => a.grasas.compareTo(b.grasas));
          } else {
            _filteredAlimentos.sort((a, b) => b.grasas.compareTo(a.grasas));
          }
          break;
        case 'fibra':
          if (currentOrderOption == _orderOptions[0]) {
            _filteredAlimentos.sort((a, b) => a.fibra.compareTo(b.fibra));
          } else {
            _filteredAlimentos.sort((a, b) => b.fibra.compareTo(a.fibra));
          }
          break;
        case 'calorias':
          if (currentOrderOption == _orderOptions[0]) {
            _filteredAlimentos.sort((a, b) => a.calorias.compareTo(b.calorias));
          } else {
            _filteredAlimentos.sort((a, b) => b.calorias.compareTo(a.calorias));
          }
          break;
      }
    });
    setData();
  }
}
