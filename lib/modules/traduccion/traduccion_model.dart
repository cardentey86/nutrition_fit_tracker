class AlimentoTraduccion {
  final int? id;
  final int idAlimento;
  final String code;
  final String nombreAlimento;

  AlimentoTraduccion({
    this.id,
    required this.idAlimento,
    required this.code,
    required this.nombreAlimento,
  });

  factory AlimentoTraduccion.fromMap(Map<String, dynamic> map) {
    return AlimentoTraduccion(
        id: map['Id'],
        idAlimento: map['IdAlimento'],
        code: map['Code'],
        nombreAlimento: map['NombreAlimento']);
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': id,
      'Nombre': nombreAlimento,
      'Code': code,
      'idAlimento': idAlimento,
    };
  }
}
