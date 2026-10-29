import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../modelos/pais.dart';
import '../servicos/dados_servico.dart';
import 'tela_resultado.dart';

class TelaJogo extends StatefulWidget {
  final bool modoAleatorio;
  final String continente;
  final int tempoTotal;
  final String idioma;
  final String dificuldade;

  const TelaJogo({
    super.key,
    required this.modoAleatorio,
    required this.continente,
    required this.tempoTotal,
    required this.idioma,
    required this.dificuldade,
  });

  @override
  State<TelaJogo> createState() => _TelaJogoState();
}

class _TelaJogoState extends State<TelaJogo> {
  late List<Pais> listaFiltrada;
  late Pais paisCorreto;
  List<Pais> opcoes = [];

  int pontuacao = 0;
  int perguntasRespondidas = 0;
  late int tempoRestante;
  Timer? cronometro;

  Pais? paisSelecionadoUsuario;
  bool aguardandoProxima = false;

  @override
  void initState() {
    super.initState();
    tempoRestante = widget.tempoTotal;
    listaFiltrada = DadosServico.filtrarPaises(widget.modoAleatorio, widget.continente, widget.dificuldade);
    _gerarPergunta();
    _iniciarCronometro();
  }

  void _iniciarCronometro() {
    cronometro = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (tempoRestante > 0) {
        setState(() => tempoRestante--);
      } else {
        _finalizarJogo();
      }
    });
  }

  void _gerarPergunta() {
    if (listaFiltrada.length < 4) {
      _finalizarJogo();
      return;
    }

    final random = Random();
    List<Pais> copiaLista = List.from(listaFiltrada);
    copiaLista.shuffle();

    paisCorreto = copiaLista[0];
    opcoes = copiaLista.sublist(0, 4);
    opcoes.shuffle(random);

    paisSelecionadoUsuario = null;
    aguardandoProxima = false;
  }

  void _verificarResposta(Pais paisEscolhido) {
    if (aguardandoProxima) return;

    setState(() {
      aguardandoProxima = true;
      paisSelecionadoUsuario = paisEscolhido;
      perguntasRespondidas++;
      if (paisEscolhido.codigo == paisCorreto.codigo) {
        pontuacao++;
      }
    });

    Future.delayed(const Duration(milliseconds: 700), () {
      if (tempoRestante > 0 && mounted) {
        setState(() => _gerarPergunta());
      }
    });
  }

  void _finalizarJogo() {
    cronometro?.cancel();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => TelaResultado(
          pontuacao: pontuacao,
          totalPerguntas: perguntasRespondidas,
          idioma: widget.idioma,
        ),
      ),
    );
  }

  @override
  void dispose() {
    cronometro?.cancel();
    super.dispose();
  }

  Color _obterCorBotao(Pais pais) {
    if (paisSelecionadoUsuario == null) return Colors.white;
    if (pais.codigo == paisCorreto.codigo) return Colors.green.shade300;
    if (pais.codigo == paisSelecionadoUsuario?.codigo) return Colors.red.shade300;
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      appBar: AppBar(
        title: Text('⏱️ 00:${tempoRestante.toString().padLeft(2, '0')}  |  ⭐ $pontuacao'),
        backgroundColor: const Color(0xFF3F51B5),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: listaFiltrada.length < 4
          ? const Center(child: Text("Países insuficientes para esta configuração."))
          : Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              height: 190,
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10, offset: const Offset(0, 4))],
              ),
              child: SvgPicture.asset(
                paisCorreto.caminhoBandeira,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 35),

            Expanded(
              child: ListView.builder(
                itemCount: opcoes.length,
                itemBuilder: (context, index) {
                  final pais = opcoes[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _obterCorBotao(pais),
                        foregroundColor: Colors.black87,
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 2,
                      ),
                      onPressed: () => _verificarResposta(pais),
                      child: Text(
                          pais.obterNome(widget.idioma),
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}