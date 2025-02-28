class Alimento {
  final String nombre;
  final double calorias;
  final double carbohidratos;
  final double proteinas;
  final double grasas;
  final double fibra;

  Alimento({
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

  Map<String, dynamic> toMap() {
    return {
      'Alimento': nombre,
      'Calorias': calorias,
      'Carbohidratos': carbohidratos,
      'Proteinas': proteinas,
      'Grasas': grasas,
      'Fibra': fibra,
    };
  }
}
