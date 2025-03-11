import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IndiceBtn extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final String image;
  const IndiceBtn(
      {super.key,
      required this.text,
      required this.image,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Column(
        children: [
          Material(
            elevation: 8.0,
            shadowColor: Colors.grey.withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Container(
              padding: const EdgeInsets.all(8),
              child: SvgPicture.asset(
                image, // Ruta a tu archivo SVG
                width: 30, // Ancho deseado
                height: 30, // Alto deseado
                fit: BoxFit.cover, // Ajuste de la imagen
              ),
            ),
          ),
        ],
      ),
    );
  }
}
