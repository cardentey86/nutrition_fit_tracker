class PersonalMeasure {
  int id;
  String fecha;
  int edad;
  String sexo;
  int objetivo;
  int nivelActividad;
  double estatura;
  double peso;
  double cintura;
  double cadera;
  double cuello;
  double muneca;
  double tobillo;
  double pecho;
  double biceps;
  double antebrazo;
  double muslo;
  double gemelos;

  PersonalMeasure({
    required this.id,
    required this.fecha,
    required this.edad,
    required this.sexo,
    required this.objetivo,
    required this.nivelActividad,
    required this.estatura,
    required this.peso,
    required this.cintura,
    required this.cadera,
    required this.cuello,
    required this.muneca,
    required this.tobillo,
    required this.pecho,
    required this.biceps,
    required this.antebrazo,
    required this.muslo,
    required this.gemelos,
  });

  factory PersonalMeasure.fromMap(Map<String, dynamic> map) {
    return PersonalMeasure(
      id: map['Id'],
      fecha: map['Fecha'],
      edad: map['Edad'],
      sexo: map['Sexo'],
      objetivo: map['Objetivo'],
      nivelActividad: map['NivelActividad'],
      estatura: map['Estatura'],
      peso: map['Peso'],
      cintura: map['Cintura'],
      cadera: map['Cadera'],
      cuello: map['Cuello'],
      muneca: map['Muneca'],
      tobillo: map['Tobillo'],
      pecho: map['Pecho'],
      biceps: map['Biceps'],
      antebrazo: map['Antebrazo'],
      muslo: map['Muslo'],
      gemelos: map['Gemelos'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': id,
      'Fecha': fecha,
      'Edad': edad,
      'Sexo': sexo,
      'Objetivo': objetivo,
      'NivelActividad': nivelActividad,
      'Estatura': estatura,
      'Peso': peso,
      'Cintura': cintura,
      'Cadera': cadera,
      'Cuello': cuello,
      'Muneca': muneca,
      'Tobillo': tobillo,
      'Pecho': pecho,
      'Biceps': biceps,
      'Antebrazo': antebrazo,
      'Muslo': muslo,
      'Gemelos': gemelos,
    };
  }
}
