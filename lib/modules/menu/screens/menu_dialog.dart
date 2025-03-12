import 'package:flutter/material.dart';

class MenuDialog extends StatefulWidget {
  final List<String> menuNames;
  final Function(String, String) onAddMenu;

  const MenuDialog(
      {super.key, required this.menuNames, required this.onAddMenu});

  @override
  State createState() => _MenuDialogState();
}

class _MenuDialogState extends State<MenuDialog> {
  String? selectedMenuName;
  String description = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Crear Menú'),
      content: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: selectedMenuName,
              hint: const Text('Seleccione un menú'),
              onChanged: (String? newValue) {
                setState(() {
                  selectedMenuName = newValue;
                  description = ''; // Reinicia la descripción al cambiar
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Por favor, seleccione un menú';
                }
                return null; // Valido
              },
              items: widget.menuNames
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  description = value; // Guarda la descripción
                });
              },
              decoration:
                  const InputDecoration(hintText: "Descripción del menú"),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Agregar'),
          onPressed: () {
            if (selectedMenuName != null) {
              widget.onAddMenu(selectedMenuName!, description);
            }
          },
        ),
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
