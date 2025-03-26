import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_fit_traker/modules/layout/screens/home_drawer.dart';
import 'package:nutrition_fit_traker/routes/router_handler.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  String _selectedRoute = '/';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("layout.title".tr()),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
          backgroundColor: Colors.blue,
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            IconButton(
              onPressed: () {
                exit(0);
              },
              icon: const Icon(Icons.exit_to_app_outlined),
            ),
          ],
        ),
        body: RouterHandler(selectedRoute: _selectedRoute),
        drawer: HomeDrawer(onItemTapped: onItemTapped),
      ),
    );
  }

  void onItemTapped(String route) {
    setState(() {
      _selectedRoute = route;
    });

    if (_scaffoldKey.currentState!.isDrawerOpen) {
      Navigator.of(context).pop();
    }
  }
}
