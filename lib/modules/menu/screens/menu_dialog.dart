import 'package:easy_localization/easy_localization.dart';
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
      title: Text('menuFood.dialog.title'.tr()),
      content: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: selectedMenuName,
              hint: Text('menuFood.dialog.select'.tr()),
              onChanged: (String? newValue) {
                setState(() {
                  selectedMenuName = newValue;
                  description = ''; // Reinicia la descripción al cambiar
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'menuFood.dialog.errorSelect'
                      .tr(); // Mensaje de error si no se selecciona un menú
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
                  InputDecoration(hintText: 'menuFood.dialog.desc'.tr()),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('menuFood.dialog.btnAdd'.tr()),
          onPressed: () {
            if (selectedMenuName != null) {
              widget.onAddMenu(selectedMenuName!, description);
            }
          },
        ),
        TextButton(
          child: Text('menuFood.dialog.btnCancel'.tr()),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
