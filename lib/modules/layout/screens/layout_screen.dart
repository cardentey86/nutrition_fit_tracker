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
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("Nutrition Fitness Tracker"),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: RouterHandler(selectedRoute: _selectedRoute),
      drawer: HomeDrawer(onItemTapped: onItemTapped),
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
