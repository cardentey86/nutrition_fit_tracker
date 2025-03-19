import 'package:flutter/material.dart';
import 'package:nutrition_fit_traker/modules/menu/widgets/macro_card.dart';

class NutritionScreen extends StatelessWidget {
  final double valueCal;
  final double maxValueCal;
  final double valueProt;
  final double maxValueProt;
  final double valueCarb;
  final double maxValueCarb;
  final double valueGrasa;
  final double maxValueGrasa;
  const NutritionScreen(
      {super.key,
      required this.valueCal,
      required this.maxValueCal,
      required this.valueProt,
      required this.maxValueProt,
      required this.valueCarb,
      required this.maxValueCarb,
      required this.valueGrasa,
      required this.maxValueGrasa});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(maxValueCal.toStringAsFixed(2)),
              MacroCard(
                  label: "Kcal",
                  value: valueCal,
                  maxValue: maxValueCal,
                  color: Colors.orange),
              Text(valueCal.toStringAsFixed(2)),
            ],
          ),
          Column(
            children: [
              Text(maxValueProt.toStringAsFixed(2)),
              MacroCard(
                  label: "Protein",
                  value: valueProt,
                  maxValue: maxValueProt,
                  color: Colors.blue),
              Text(valueProt.toStringAsFixed(2)),
            ],
          ),
          Column(
            children: [
              Text(maxValueCarb.toStringAsFixed(2)),
              MacroCard(
                  label: "Carb",
                  value: valueCarb,
                  maxValue: maxValueCarb,
                  color: Colors.red),
              Text(valueCarb.toStringAsFixed(2)),
            ],
          ),
          Column(
            children: [
              Text(maxValueGrasa.toStringAsFixed(2)),
              MacroCard(
                  label: "Grasas",
                  value: valueGrasa,
                  maxValue: maxValueGrasa,
                  color: Colors.green),
              Text(valueGrasa.toStringAsFixed(2)),
            ],
          ),
        ],
      ),
    );
  }
}
