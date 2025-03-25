class Languajes {
  String code;
  String languaje;

  Languajes({required this.code, required this.languaje});

  static List<Languajes> getLanguajes() {
    return [
      Languajes(code: 'es', languaje: "Español"),
      Languajes(code: 'en', languaje: "Inglés"),
      Languajes(code: 'fr', languaje: "Francés"),
      Languajes(code: 'gr', languaje: "Alemán"),
    ];
  }
}
