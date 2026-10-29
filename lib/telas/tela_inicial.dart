import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../servicos/idioma_servico.dart';
import 'tela_jogo.dart';
import 'tela_revisao.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  String idiomaAtual = 'pt';
  bool modoAleatorio = true;
  String continenteSelecionado = 'América';
  String dificuldadeSelecionada = 'facil';
  int tempoSelecionado = 60;
  int recordeLocal = 0;

  final List<String> continentes = ['África', 'América', 'Ásia', 'Europa', 'Oceania'];

  @override
  void initState() {
    super.initState();
    _carregarRecorde();
  }

  Future<void> _carregarRecorde() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() => recordeLocal = prefs.getInt('recorde') ?? 0);
  }

  String t(String chave) => IdiomaServico.obterTexto(idiomaAtual, chave);

  void _iniciarJogo() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaJogo(
          modoAleatorio: modoAleatorio,
          continente: continenteSelecionado,
          tempoTotal: tempoSelecionado,
          idioma: idiomaAtual,
          dificuldade: dificuldadeSelecionada,
        ),
      ),
    ).then((_) => _carregarRecorde());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)],
                  ),
                  child: DropdownButton<String>(
                    value: idiomaAtual,
                    underline: const SizedBox(),
                    icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF2E3192)),
                    items: const [
                      DropdownMenuItem(value: 'pt', child: Text('🇧🇷 PT', style: TextStyle(fontWeight: FontWeight.bold))),
                      DropdownMenuItem(value: 'en', child: Text('🇺🇸 EN', style: TextStyle(fontWeight: FontWeight.bold))),
                      DropdownMenuItem(value: 'es', child: Text('🇪🇸 ES', style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                    onChanged: (val) => setState(() => idiomaAtual = val!),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1CB5E0), Color(0xFF000046)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [BoxShadow(color: const Color(0xFF000046).withOpacity(0.4), blurRadius: 12, offset: const Offset(0, 6))],
                ),
                child: Column(
                  children: [
                    const Icon(Icons.travel_explore, size: 70, color: Colors.white),
                    const SizedBox(height: 10),
                    Text(t('titulo'), style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 1)),
                    const SizedBox(height: 5),
                    Text(t('subtitulo'), style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.9))),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.emoji_events, color: Colors.white, size: 20),
                          const SizedBox(width: 8),
                          Text('${t('recorde')}: $recordeLocal', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => modoAleatorio = true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: modoAleatorio ? const Color(0xFF2E3192) : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFF2E3192), width: 2),
                          boxShadow: modoAleatorio ? [BoxShadow(color: const Color(0xFF2E3192).withOpacity(0.3), blurRadius: 8)] : [],
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.shuffle, color: modoAleatorio ? Colors.white : const Color(0xFF2E3192)),
                            const SizedBox(height: 8),
                            Text(t('aleatorio'), textAlign: TextAlign.center, style: TextStyle(color: modoAleatorio ? Colors.white : const Color(0xFF2E3192), fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => modoAleatorio = false),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: !modoAleatorio ? const Color(0xFF2E3192) : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFF2E3192), width: 2),
                          boxShadow: !modoAleatorio ? [BoxShadow(color: const Color(0xFF2E3192).withOpacity(0.3), blurRadius: 8)] : [],
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.map, color: !modoAleatorio ? Colors.white : const Color(0xFF2E3192)),
                            const SizedBox(height: 8),
                            Text(t('continente'), textAlign: TextAlign.center, style: TextStyle(color: !modoAleatorio ? Colors.white : const Color(0xFF2E3192), fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                child: !modoAleatorio
                    ? Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 5)]),
                  child: DropdownButton<String>(
                    value: continenteSelecionado,
                    isExpanded: true,
                    underline: const SizedBox(),
                    icon: const Icon(Icons.arrow_drop_down_circle, color: Color(0xFF2E3192)),
                    items: continentes.map((c) => DropdownMenuItem(value: c, child: Text(t(c.toLowerCase()), style: const TextStyle(fontWeight: FontWeight.w600)))).toList(),
                    onChanged: (val) => setState(() => continenteSelecionado = val!),
                  ),
                )
                    : const SizedBox.shrink(),
              ),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 5)]),
                      child: DropdownButton<String>(
                        value: dificuldadeSelecionada,
                        isExpanded: true,
                        underline: const SizedBox(),
                        items: [
                          DropdownMenuItem(value: 'facil', child: Text(t('facil'), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600))),
                          DropdownMenuItem(value: 'dificil', child: Text(t('dificil'), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600))),
                        ],
                        onChanged: (val) => setState(() => dificuldadeSelecionada = val!),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 5)]),
                      child: DropdownButton<int>(
                        value: tempoSelecionado,
                        isExpanded: true,
                        underline: const SizedBox(),
                        items: [
                          DropdownMenuItem(value: 30, child: Text(t('t_30s'), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600))),
                          DropdownMenuItem(value: 60, child: Text(t('t_60s'), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600))),
                          DropdownMenuItem(value: 180, child: Text(t('t_3m'), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600))),
                          DropdownMenuItem(value: 300, child: Text(t('t_5m'), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600))),
                        ],
                        onChanged: (val) => setState(() => tempoSelecionado = val!),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00C9FF), // Azul vibrante
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 5,
                  shadowColor: const Color(0xFF00C9FF).withOpacity(0.5),
                ),
                onPressed: _iniciarJogo,
                child: Text(t('jogar'), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF2E3192),
                  side: const BorderSide(color: Color(0xFF2E3192), width: 2),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                icon: const Icon(Icons.school),
                label: Text(t('estudar'), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TelaRevisao(idioma: idiomaAtual))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}