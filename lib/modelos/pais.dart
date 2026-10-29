class Pais {
  final String codigo;
  final String continente;
  final String dificuldade;
  final Map<String, dynamic> nomes;

  Pais({
    required this.codigo,
    required this.continente,
    required this.dificuldade,
    required this.nomes,
  });

  factory Pais.fromJson(Map<String, dynamic> json) {
    return Pais(
      codigo: json['codigo'] ?? '',
      continente: json['continente'] ?? 'Desconhecido',
      dificuldade: json['dificuldade'] ?? 'facil',
      nomes: json['nomes'] ?? {'pt': 'Desconhecido', 'en': 'Unknown', 'es': 'Desconocido'},
    );
  }

  String obterNome(String idioma) {
    return nomes[idioma] ?? nomes['pt'];
  }

  String get caminhoBandeira => 'assets/bandeiras/$codigo.svg';
}