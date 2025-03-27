import 'package:nutrition_fit_traker/modules/traduccion/traduccion_model.dart';

enum CategoriaAlimento {
  // ignore: constant_identifier_names
  Proteinas(1),
  // ignore: constant_identifier_names
  Carbohidratos(2),
  // ignore: constant_identifier_names
  Vegetales(3),
  // ignore: constant_identifier_names
  Grasas(4),
  // ignore: constant_identifier_names
  Frutas(5),
  // ignore: constant_identifier_names
  Otros(6);

  final int value;

  const CategoriaAlimento(this.value);
}

class Alimento {
  final int? id;
  final String nombre;
  final double calorias;
  final double carbohidratos;
  final double proteinas;
  final double grasas;
  final double fibra;

  Alimento({
    this.id,
    required this.nombre,
    required this.calorias,
    required this.carbohidratos,
    required this.proteinas,
    required this.grasas,
    required this.fibra,
  });

  factory Alimento.fromJson(Map<String, dynamic> json) {
    return Alimento(
      nombre: json['Alimento'],
      calorias: (json['Calorias'] is int)
          ? (json['Calorias'] as int).toDouble()
          : json['Calorias'] as double,
      carbohidratos: (json['Carbohidratos'] is int)
          ? (json['Carbohidratos'] as int).toDouble()
          : json['Carbohidratos'] as double,
      proteinas: (json['Proteinas'] is int)
          ? (json['Proteinas'] as int).toDouble()
          : json['Proteinas'] as double,
      grasas: (json['Grasas'] is int)
          ? (json['Grasas'] as int).toDouble()
          : json['Grasas'] as double,
      fibra: (json['Fibra'] is int)
          ? (json['Fibra'] as int).toDouble()
          : json['Fibra'] as double,
    );
  }

  factory Alimento.fromMap(
      Map<String, dynamic> map, AlimentoTraduccion traduccion) {
    return Alimento(
      id: map['Id'],
      nombre: traduccion.nombreAlimento,
      calorias: (map['Calorias'] is int)
          ? (map['Calorias'] as int).toDouble()
          : map['Calorias'],
      carbohidratos: map['Carbohidratos'],
      proteinas: map['Proteinas'],
      grasas: map['Grasas'],
      fibra: map['Fibra'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': id,
      'Nombre': nombre,
      'Calorias': calorias,
      'Carbohidratos': carbohidratos,
      'Proteinas': proteinas,
      'Grasas': grasas,
      'Fibra': fibra,
    };
  }
}
