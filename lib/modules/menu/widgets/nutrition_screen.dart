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
  final VoidCallback onValueChangedCalorias;
  final VoidCallback onValueChangedCarbohidratos;
  final VoidCallback onValueChangedProteinas;
  final VoidCallback onValueChangedGrasas;
  const NutritionScreen(
      {super.key,
      required this.valueCal,
      required this.maxValueCal,
      required this.valueProt,
      required this.maxValueProt,
      required this.valueCarb,
      required this.maxValueCarb,
      required this.valueGrasa,
      required this.maxValueGrasa,
      required this.onValueChangedCalorias,
      required this.onValueChangedCarbohidratos,
      required this.onValueChangedProteinas,
      required this.onValueChangedGrasas});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Recomendado / Planificado',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(maxValueCal.toStringAsFixed(1)),
                  const SizedBox(
                    height: 8,
                  ),
                  MacroCard(
                    label: "Kcal",
                    value: valueCal,
                    maxValue: maxValueCal,
                    color: Colors.orange,
                    onValueChanged: onValueChangedCalorias,
                  ),
                  Text(valueCal.toStringAsFixed(1)),
                ],
              ),
              Column(
                children: [
                  Text(maxValueProt.toStringAsFixed(1)),
                  const SizedBox(
                    height: 8,
                  ),
                  MacroCard(
                    label: "Protein",
                    value: valueProt,
                    maxValue: maxValueProt,
                    color: Colors.blue,
                    onValueChanged: onValueChangedProteinas,
                  ),
                  Text(valueProt.toStringAsFixed(1)),
                ],
              ),
              Column(
                children: [
                  Text(maxValueCarb.toStringAsFixed(1)),
                  const SizedBox(
                    height: 8,
                  ),
                  MacroCard(
                    label: "Carb",
                    value: valueCarb,
                    maxValue: maxValueCarb,
                    color: Colors.red,
                    onValueChanged: onValueChangedCarbohidratos,
                  ),
                  Text(valueCarb.toStringAsFixed(1)),
                ],
              ),
              Column(
                children: [
                  Text(maxValueGrasa.toStringAsFixed(1)),
                  const SizedBox(
                    height: 8,
                  ),
                  MacroCard(
                    label: "Grasas",
                    value: valueGrasa,
                    maxValue: maxValueGrasa,
                    color: Colors.green,
                    onValueChanged: onValueChangedGrasas,
                  ),
                  Text(valueGrasa.toStringAsFixed(1)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
