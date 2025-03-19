import 'package:flutter/material.dart';

class MacroCard extends StatelessWidget {
  final String label;
  final double value;
  final double maxValue;
  final Color color;

  const MacroCard({
    super.key,
    required this.label,
    required this.value,
    required this.color,
    required this.maxValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                value: double.parse((value / maxValue).toStringAsFixed(2)),
                backgroundColor: Colors.black12,
                valueColor: AlwaysStoppedAnimation(color),
                strokeWidth: 6,
              ),
            ),
            Text(
              (maxValue - value) > 0
                  ? "${(maxValue - value).toStringAsFixed(2)}\nFaltan"
                  : '${(maxValue - value).toStringAsFixed(2)}\nSobran',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black87, fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
              color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
