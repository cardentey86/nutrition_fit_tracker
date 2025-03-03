import 'package:flutter/material.dart';

class MedidasPersonales extends StatefulWidget {
  const MedidasPersonales({super.key});

  @override
  State<MedidasPersonales> createState() => _MedidasPersonalesState();
}

class _MedidasPersonalesState extends State<MedidasPersonales> {
  bool isMenuOpen = false;

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
              child: Icon(
                isMenuOpen ? Icons.close : Icons.menu,
                key: ValueKey<bool>(isMenuOpen),
              ),
            )
          ],
        ));
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
