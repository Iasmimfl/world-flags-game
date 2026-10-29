import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../modelos/pais.dart';
import '../servicos/dados_servico.dart';
import '../servicos/idioma_servico.dart';

class TelaRevisao extends StatefulWidget {
  final String idioma;
  const TelaRevisao({super.key, required this.idioma});

  @override
  State<TelaRevisao> createState() => _TelaRevisaoState();
}

class _TelaRevisaoState extends State<TelaRevisao> {
  List<Pais> paises = [];
  String pesquisa = "";

  @override
  void initState() {
    super.initState();

    paises = List.from(DadosServico.todosOsPaises);
    paises.sort((a, b) => a.obterNome(widget.idioma).compareTo(b.obterNome(widget.idioma)));
  }

  String t(String chave) => IdiomaServico.obterTexto(widget.idioma, chave);

  @override
  Widget build(BuildContext context) {
    List<Pais> filtrados = paises
        .where((p) => p.obterNome(widget.idioma).toLowerCase().contains(pesquisa.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        title: Text(t('estudar'), style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF2E3192),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            color: const Color(0xFF2E3192),
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: t('pesquisar'),
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                filled: true,
                fillColor: Colors.white.withOpacity(0.15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (val) => setState(() => pesquisa = val),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.9,
              ),
              itemCount: filtrados.length,
              itemBuilder: (context, index) {
                final pais = filtrados[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 4))],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 70,
                        width: 100,
                        decoration: BoxDecoration(
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, 2))],
                        ),
                        child: SvgPicture.asset(pais.caminhoBandeira, fit: BoxFit.cover),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          pais.obterNome(widget.idioma),
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF1E293B)),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}