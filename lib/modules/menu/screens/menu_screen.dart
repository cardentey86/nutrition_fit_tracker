import 'package:flutter/material.dart';
import 'package:nutrition_fit_traker/modules/food/infrastructure/food_controller.dart';
import 'package:nutrition_fit_traker/modules/food/models/food_model.dart';
import 'package:nutrition_fit_traker/modules/menu/infrastructure/menu_plato_controller.dart';
import 'package:nutrition_fit_traker/modules/menu/models/menu.dart';
import 'package:nutrition_fit_traker/modules/menu/models/menu_plato.dart';
import 'package:nutrition_fit_traker/modules/menu/models/show_macro.dart';
import 'package:nutrition_fit_traker/modules/menu/screens/menu_dialog.dart';
import 'package:nutrition_fit_traker/modules/menu/screens/menu_plato_dialog.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MenuScreen> {
  ShowMacro? macrosGeneral;
  List<ShowMacro> listMacrosPorMenu = List.empty();

  List<Menu> menus = [];
  List<String> menuNames = [];
  List<Alimento> alimentos = [];
  List<MenuPlato> menuPlato = [];
  String? selectedMenuName;
  final MenuPlatoController _menuPlatoController = MenuPlatoController();
  final FoodController _alimentoController = FoodController();
  String? description;
  bool isMenuOpen = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    menuNames = Menu.menuNames();
    _loadData();
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

    calculateTotalMacro(menus);

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
    setState(() {
      _isLoading = false;
    });
  }

  void calculateTotalMacro(List<Menu> menus) {
    double calorias = 0;
    double proteinas = 0;
    double carbohidratos = 0;
    double grasas = 0;

    for (var menu in menus) {
      if (menu.platos.isNotEmpty) {
        for (var plato in menu.platos) {
          if (plato.alimento != null) {
            calorias += (plato.cantidad * plato.alimento!.calorias / 100);
            proteinas += (plato.cantidad * plato.alimento!.proteinas / 100);
            carbohidratos +=
                (plato.cantidad * plato.alimento!.carbohidratos / 100);
            grasas += (plato.cantidad * plato.alimento!.grasas / 100);
          }
        }
      }
    }
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
              const Text(
                'Necesidades de Macronutrientes',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Text('Calorias'),
                      Text(
                        macrosGeneral!.calorias.toStringAsFixed(2),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text('Proteínas'),
                      Text(macrosGeneral!.proteinas.toStringAsFixed(2),
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Column(
                    children: [
                      const Text('Carbohidratos'),
                      Text(macrosGeneral!.carbohidratos.toStringAsFixed(2),
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Column(
                    children: [
                      const Text('Grasas'),
                      Text(macrosGeneral!.grasas.toStringAsFixed(2),
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
              const Divider(
                height: 16,
              ),
              const Text(
                'Planificación de Macronutrientes',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Text('Calorias'),
                      Text(
                        macrosGeneral!.calorias.toStringAsFixed(2),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text('Proteínas'),
                      Text(macrosGeneral!.proteinas.toStringAsFixed(2),
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Column(
                    children: [
                      const Text('Carbohidratos'),
                      Text(macrosGeneral!.carbohidratos.toStringAsFixed(2),
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Column(
                    children: [
                      const Text('Grasas'),
                      Text(macrosGeneral!.grasas.toStringAsFixed(2),
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
              const Divider(
                height: 16,
              ),
              Expanded(
                child: ListView(
                  children: menus.map((Menu menu) {
                    return ExpansionTile(
                        key: Key(menu.id.toString()),
                        title: Text(menu.nombre),
                        subtitle: Row(
                          children: [
                            Column(
                              children: [Text('Calorias')],
                            )
                          ],
                        ),
                        children: menu.platos.map((MenuPlato plato) {
                          return ListTile(
                            key: Key(plato.id.toString()),
                            title: Text(plato.alimento!.nombre),
                          );
                        }).toList());
                  }).toList(),
                ),
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
