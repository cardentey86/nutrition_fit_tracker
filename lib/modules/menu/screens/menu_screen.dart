import 'package:flutter/material.dart';
import 'package:nutrition_fit_traker/modules/menu/infrastructure/menu_plato_controller.dart';
import 'package:nutrition_fit_traker/modules/menu/models/menu.dart';
import 'package:nutrition_fit_traker/modules/menu/models/menu_plato.dart';
import 'package:nutrition_fit_traker/modules/menu/screens/menu_dialog.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MenuScreen> {
  double calorias = 0;
  double proteinas = 0;
  double carbohidratos = 0;
  double grasas = 0;
  List<Menu> menus = [];
  List<String> menuNames = [];
  String? selectedMenuName;
  final MenuPlatoController _menuPlatoController = MenuPlatoController();
  String? description;

  @override
  void initState() {
    super.initState();
    menuNames = Menu.menuNames();
    getAllMenu();
  }

  Future<void> getAllMenu() async {
    final result = await _menuPlatoController.getAll();
    setState(() {
      menus = [...result];
    });
  }

  Future<void> insertMenu(
    String name,
  ) async {
    Menu menu = Menu(nombre: name, platos: List.empty());
    await _menuPlatoController.insertMenu(menu);
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
              await getAllMenu();
            } else {
              showSnackBar(context, 'El menú ya existe');
            }

            if (mounted) {
              Navigator.of(context).pop();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Menú',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton(
          elevation: 4,
          backgroundColor: Colors.blue,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
          onPressed: _showMenuDialog,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
      body: Padding(
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
                      calorias.toStringAsFixed(2),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text('Proteínas'),
                    Text(proteinas.toStringAsFixed(2),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  children: [
                    const Text('Carbohidratos'),
                    Text(carbohidratos.toStringAsFixed(2),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  children: [
                    const Text('Grasas'),
                    Text(grasas.toStringAsFixed(2),
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
                      calorias.toStringAsFixed(2),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text('Proteínas'),
                    Text(proteinas.toStringAsFixed(2),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  children: [
                    const Text('Carbohidratos'),
                    Text(carbohidratos.toStringAsFixed(2),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  children: [
                    const Text('Grasas'),
                    Text(grasas.toStringAsFixed(2),
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
    );
  }
}
