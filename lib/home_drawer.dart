import 'package:flutter/material.dart';
import 'package:nutrition_fit_traker/drawer_menu_options.dart';
import 'package:nutrition_fit_traker/drawer_model.dart';

class HomeDrawer extends StatefulWidget {
  final Function(String) onItemTapped;
  const HomeDrawer({super.key, required this.onItemTapped});

  @override
  State<HomeDrawer> createState() => HomeDrawerState();
}

class HomeDrawerState extends State<HomeDrawer> {
  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Nutrition Fit Tracker',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: drawerMenu.asMap().entries.map((entry) {
              final int index = entry.key;
              final ParentItem parent = entry.value;
              return ExpansionTile(
                dense: true,
                title: Text(parent.title),
                leading: parent.icon,
                initiallyExpanded: expandedIndex == index,
                onExpansionChanged: (isExpanded) {
                  setState(() {
                    expandedIndex = index;
                  });
                },
                children: parent.children.map((child) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: ListTile(
                      dense: true,
                      leading: child.icon,
                      title: Text(child.text),
                      onTap: () {
                        widget.onItemTapped(child.route);
                      },
                    ),
                  );
                }).toList(),
              );
            }).toList(),
          )
        ]),
      ),
    );
  }
}
