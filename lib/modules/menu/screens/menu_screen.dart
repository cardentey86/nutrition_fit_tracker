import 'package:flutter/material.dart';
import 'package:nutrition_fit_traker/modules/food/infrastructure/food_controller.dart';
import 'package:nutrition_fit_traker/modules/food/models/food_model.dart';
import 'package:nutrition_fit_traker/modules/indices/infrastructure/indices_controller.dart';
import 'package:nutrition_fit_traker/modules/indices/models/consumo_macro.dart';
import 'package:nutrition_fit_traker/modules/menu/infrastructure/menu_plato_controller.dart';
import 'package:nutrition_fit_traker/modules/menu/models/chart_model.dart';
import 'package:nutrition_fit_traker/modules/menu/models/menu.dart';
import 'package:nutrition_fit_traker/modules/menu/models/menu_plato.dart';
import 'package:nutrition_fit_traker/modules/menu/models/show_macro.dart';
import 'package:nutrition_fit_traker/modules/menu/screens/menu_dialog.dart';
import 'package:nutrition_fit_traker/modules/menu/screens/menu_plato_dialog.dart';
import 'package:nutrition_fit_traker/modules/menu/widgets/chart_macro.dart';
import 'package:nutrition_fit_traker/modules/menu/widgets/nutrition_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MenuScreen> with TickerProviderStateMixin {
  ShowMacro? macrosPlanGeneral;
  List<ShowMacro> listMacrosPlanPorMenu = [];

  List<Menu> menus = [];
  List<String> menuNames = [];
  List<Alimento> alimentos = [];
  List<MenuPlato> menuPlato = [];
  String? selectedMenuName;
  final MenuPlatoController _menuPlatoController = MenuPlatoController();
  final FoodController _alimentoController = FoodController();
  final IndicesController _indicesController = IndicesController();
  String? description;
  bool isMenuOpen = false;
  bool _isLoading = false;
  ConsumoMacro? necesidadesMacro;
  List<Data> pastelMacroCalorias = [];
  List<Data> pastelMacroProteina = [];
  List<Data> pastelMacroCarbohidratos = [];
  List<Data> pastelMacroGrasas = [];
  bool showPastel = false;
  late AnimationController _controller; // Controlador de animación
  late Animation<Offset> _slideAnimation; // Animación de deslizamiento

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));

    menuNames = Menu.menuNames();
    _loadData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });
    final resultMenu = await _menuPlatoController.getAllMenu();
    menus = [...resultMenu];

    final resultAlimentos = await _alimentoController.getAlimentos();
    alimentos = [...resultAlimentos];

    final resultMenuPlato = await _menuPlatoController.getAllMenuPlato();
    menuPlato = [...resultMenuPlato];

    final macroGeneral =
        await _indicesController.consumoMacroNutrientesDesglosado();
    necesidadesMacro = macroGeneral;

    calculateMacroPlanificado(menus);

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> getAllMenu() async {
    setState(() {
      _isLoading = true;
    });
    final result = await _menuPlatoController.getAllMenu();
    menus = [...result];
    calculateMacroPlanificado(menus);
    setState(() {
      _isLoading = false;
    });
  }

  void toggleShowPastel() {
    setState(() {
      showPastel = !showPastel;
      if (showPastel) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  void calculateMacroPlanificado(List<Menu> menus) {
    double calorias = 0;
    double proteinas = 0;
    double carbohidratos = 0;
    double grasas = 0;

    for (var menu in menus) {
      String nombreMenu = menu.nombre;
      double menuPlatosCalorias = 0;
      double menuPlatosProteinas = 0;
      double menuPlatosCarbohidratos = 0;
      double menuPlatosGrasas = 0;

      if (menu.platos.isNotEmpty) {
        menuPlatosCalorias = 0;
        menuPlatosProteinas = 0;
        menuPlatosCarbohidratos = 0;
        menuPlatosGrasas = 0;

        for (var plato in menu.platos) {
          if (plato.alimento != null) {
            menuPlatosCalorias += _alimentoController.CalcularConsumoAlimento(
                plato.cantidad, plato.alimento!.calorias);
            menuPlatosProteinas += _alimentoController.CalcularConsumoAlimento(
                plato.cantidad, plato.alimento!.proteinas);
            menuPlatosCarbohidratos +=
                _alimentoController.CalcularConsumoAlimento(
                    plato.cantidad, plato.alimento!.carbohidratos);
            menuPlatosGrasas += _alimentoController.CalcularConsumoAlimento(
                plato.cantidad, plato.alimento!.grasas);
          }
        }

        calorias += menuPlatosCalorias;
        proteinas += menuPlatosProteinas;
        carbohidratos += menuPlatosCarbohidratos;
        grasas += menuPlatosGrasas;
      }

      listMacrosPlanPorMenu.add(ShowMacro(
          tipoMacro: nombreMenu,
          calorias: menuPlatosCalorias,
          proteinas: menuPlatosProteinas,
          carbohidratos: menuPlatosCarbohidratos,
          grasas: menuPlatosGrasas));
    }

    for (var element in listMacrosPlanPorMenu) {
      pastelMacroCalorias.add(Data(element.tipoMacro, element.calorias));
      pastelMacroProteina.add(Data(element.tipoMacro, element.proteinas));
      pastelMacroCarbohidratos
          .add(Data(element.tipoMacro, element.carbohidratos));
      pastelMacroGrasas.add(Data(element.tipoMacro, element.grasas));
    }

    setState(() {
      macrosPlanGeneral = ShowMacro(
          tipoMacro: 'general',
          calorias: double.parse(calorias.toStringAsFixed(1)),
          proteinas: double.parse(proteinas.toStringAsFixed(1)),
          carbohidratos: double.parse(carbohidratos.toStringAsFixed(1)),
          grasas: double.parse(grasas.toStringAsFixed(1)));
    });
  }

  Future<void> getAllAlimentos() async {
    setState(() {
      _isLoading = true;
    });
    final result = await _alimentoController.getAlimentos();
    alimentos = [...result];
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> getAllMenuPlatos() async {
    setState(() {
      _isLoading = true;
    });
    final result = await _menuPlatoController.getAllMenuPlato();
    menuPlato = [...result];
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> insertMenu(
    String name,
  ) async {
    Menu menu = Menu(nombre: name, platos: List.empty());
    await _menuPlatoController.insertMenu(menu);
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

  void _showMenuDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return MenuDialog(
          menuNames: menuNames,
          onAddMenu: (selectedMenu, description) async {
            var exist = menus.any((item) => item.nombre == selectedMenu);
            if (!exist) {
              if (selectedMenu.contains('Merienda') && description.isNotEmpty) {
                await insertMenu('$selectedMenu $description');
              } else {
                await insertMenu(selectedMenu);
              }
              toggleMenu();

              await getAllMenu();

              if (mounted) {
                Navigator.of(context).pop();
              }
            } else {
              showSnackBar(context, 'El menú ya existe');
            }
          },
        );
      },
    );
  }

  void _showAlimentoDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AddFoodDialog(
          menuNames: menus,
          alimentos: alimentos,
          onAddMenuPlato: (selectedMenu, selectedFood, quantity) async {
            var exist = menuPlato.any((item) =>
                item.idAlimento == selectedFood && item.idMenu == selectedMenu);
            if (!exist) {
              await insertMenuPlato(selectedMenu, selectedFood, quantity);
              //toggleMenu();
              await getAllMenu();
              /* if (mounted) {
                Navigator.of(context).pop();
              } */
            } else {
              showSnackBar(context, 'El alimento ya existe en el menú');
            }
          },
        );
      },
    );
  }

  void showSnackBar(BuildContext context, String s) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(s),
    ));
  }

  void toggleMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Menú',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isMenuOpen) ...[
            _buildMenuBotton(
                icon: Icons.menu_book_outlined,
                index: 0,
                onPressed: () async {
                  _showMenuDialog();
                }),
            const SizedBox(
              height: 10,
            ),
            _buildMenuBotton(
                index: 1,
                icon: Icons.food_bank_outlined,
                onPressed: () {
                  _showAlimentoDialog();
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
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 175,
              SizedBox(
                height: 240,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: const Offset(0, 4),
                      blurRadius: 4.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                child: NutritionScreen(
                  valueCal: macrosPlanGeneral!.calorias,
                  maxValueCal: necesidadesMacro!.calorias,
                  valueProt: macrosPlanGeneral!.proteinas,
                  maxValueProt: necesidadesMacro!.proteinas,
                  valueCarb: macrosPlanGeneral!.carbohidratos,
                  maxValueCarb: necesidadesMacro!.carbohidratos,
                  valueGrasa: macrosPlanGeneral!.grasas,
                  maxValueGrasa: necesidadesMacro!.grasas,
                  onValueChangedCalorias: () => toggleShowPastel(),
                  onValueChangedProteinas: () => toggleShowPastel(),
                  onValueChangedCarbohidratos: () => toggleShowPastel(),
                  onValueChangedGrasas: () => toggleShowPastel(),
                ),
              ),
              Expanded(
                child: ListView(children: [
                  if (showPastel)
                    SlideTransition(
                      position: _slideAnimation,
                      child: GraficoPastel(macros: pastelMacroCalorias),
                    ),
                  if (showPastel) const Divider(height: 16),
                  const SizedBox(
                    height: 16,
                  ),
                  ...menus.map((Menu menu) {
                    return ExpansionTile(
                        key: Key(menu.id.toString()),
                        showTrailingIcon: false,
                        title: Text(
                          menu.nombre,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 60,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: const BoxDecoration(
                                              color: Colors.orange,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                        ),
                                        Text(
                                          ' ${listMacrosPlanPorMenu.isEmpty ? 0 : listMacrosPlanPorMenu.firstWhere((test) => test.tipoMacro == menu.nombre).calorias}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 60,
                                    height: 20,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: const BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                        ),
                                        Text(
                                          ' ${listMacrosPlanPorMenu.isEmpty ? 0 : listMacrosPlanPorMenu.firstWhere((test) => test.tipoMacro == menu.nombre).proteinas}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 60,
                                    height: 20,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: const BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                        ),
                                        Text(
                                          ' ${listMacrosPlanPorMenu.isEmpty ? 0 : listMacrosPlanPorMenu.firstWhere((test) => test.tipoMacro == menu.nombre).carbohidratos}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 60,
                                    height: 20,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: const BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                        ),
                                        Text(
                                          ' ${listMacrosPlanPorMenu.isEmpty ? 0 : listMacrosPlanPorMenu.firstWhere((test) => test.tipoMacro == menu.nombre).grasas}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        children: menu.platos.map((MenuPlato plato) {
                          return ListTile(
                            key: Key(plato.id.toString()),
                            title: Row(
                              children: [
                                Text(
                                  plato.alimento!.nombre,
                                  style: const TextStyle(
                                      fontStyle: FontStyle.italic),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(' (${(plato.cantidad)} g)',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black38,
                                        fontStyle: FontStyle.italic)),
                              ],
                            ),
                            subtitle: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 60,
                                        height: 20,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                                ' ${_alimentoController.CalcularConsumoAlimento(plato.cantidad, plato.alimento!.calorias)}',
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.orange)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 60,
                                        height: 20,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                                ' ${_alimentoController.CalcularConsumoAlimento(plato.cantidad, plato.alimento!.proteinas)}',
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.blue)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 60,
                                        height: 20,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                                ' ${_alimentoController.CalcularConsumoAlimento(plato.cantidad, plato.alimento!.carbohidratos)}',
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.red)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 60,
                                        height: 20,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                                ' ${_alimentoController.CalcularConsumoAlimento(plato.cantidad, plato.alimento!.grasas)}',
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.green)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList());
                  }),
                ]),
              ),
            ],
          ),
        ),
        if (isMenuOpen)
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            color: Colors.white.withOpacity(0.7),
          ),
      ]),
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
}
