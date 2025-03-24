class ProgressModel {
  final String item;
  final List<ProgresoValores> progressValues;

  ProgressModel({required this.item, required this.progressValues});
}

class ProgresoValores {
  final String date;
  final double value;
  ProgresoValores({required this.date, required this.value});
}
