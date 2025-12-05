import 'dart:math';

import 'package:flutter/material.dart';

class MacroCard extends StatelessWidget {
  final String label;
  final double value;
  final double maxValue;
  final Color color;
  final VoidCallback onValueChanged;

  const MacroCard({
    super.key,
    required this.label,
    required this.value,
    required this.color,
    required this.maxValue,
    required this.onValueChanged,
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
              child: GestureDetector(
                onTap: () => onValueChanged(),
                child: CircularProgressIndicator(
                  value: maxValue >= value && maxValue > 0 ? double.parse((value / maxValue).toStringAsFixed(1)): value,
                  backgroundColor: Colors.black12,
                  valueColor: AlwaysStoppedAnimation(color),
                  strokeWidth: 6,
                ),
              ),
            ),
            Text(
              (maxValue - value) > 0
                  ? (maxValue - value).toStringAsFixed(1)
                  : (value).toStringAsFixed(1),
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black87, fontSize: 14),
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
