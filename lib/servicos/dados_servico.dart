import 'dart:convert';
import 'package:flutter/services.dart';
import '../modelos/pais.dart';

class DadosServico {
  static List<Pais> todosOsPaises = [];

  static Future<bool> carregarDadosLocais() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/dados_paises.json');
      final List<dynamic> jsonList = json.decode(jsonString);

      todosOsPaises = jsonList.map((j) => Pais.fromJson(j)).toList();
      return true;
    } catch (e) {
      print("Erro ao ler JSON local: $e");
      return false;
    }
  }

  static List<Pais> filtrarPaises(bool modoAleatorio, String continente, String dificuldade) {
    List<Pais> filtrados = List.from(todosOsPaises);

    if (!modoAleatorio && continente != "Todos") {
      filtrados = filtrados.where((p) => p.continente == continente).toList();
    }

    if (dificuldade == "facil") {
      filtrados = filtrados.where((p) => p.dificuldade == "facil").toList();
    }

    return filtrados;
  }
}