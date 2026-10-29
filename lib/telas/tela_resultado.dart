import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../servicos/idioma_servico.dart';

class TelaResultado extends StatefulWidget {
  final int pontuacao;
  final int totalPerguntas;
  final String idioma;

  const TelaResultado({
    super.key,
    required this.pontuacao,
    required this.totalPerguntas,
    required this.idioma,
  });

  @override
  State<TelaResultado> createState() => _TelaResultadoState();
}

class _TelaResultadoState extends State<TelaResultado> {
  bool novoRecorde = false;

  @override
  void initState() {
    super.initState();
    _salvarEVerificarRecorde();
  }

  Future<void> _salvarEVerificarRecorde() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int recordeAtual = prefs.getInt('recorde') ?? 0;

    if (widget.pontuacao > recordeAtual) {
      await prefs.setInt('recorde', widget.pontuacao);
      setState(() => novoRecorde = true);
    }
  }

  String t(String chave) => IdiomaServico.obterTexto(widget.idioma, chave);

  @override
  Widget build(BuildContext context) {
    double percentual = widget.totalPerguntas == 0
        ? 0
        : (widget.pontuacao / widget.totalPerguntas) * 100;

    Color corAproveitamento = percentual >= 70 ? Colors.green : (percentual >= 40 ? Colors.orange : Colors.red);

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        title: Text(t('fim'), style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF2E3192),
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: CircularProgressIndicator(
                      value: percentual / 100,
                      strokeWidth: 12,
                      backgroundColor: Colors.grey.shade300,
                      color: corAproveitamento,
                    ),
                  ),
                  Column(
                    children: [
                      Text('${percentual.toStringAsFixed(0)}%', style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: corAproveitamento)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),

              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15, offset: const Offset(0, 5))],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _EstatisticaItem(icone: Icons.help_outline, valor: '${widget.totalPerguntas}', rotulo: t('perguntas'), cor: Colors.blue),
                        Container(height: 40, width: 1, color: Colors.grey.shade200),
                        _EstatisticaItem(icone: Icons.check_circle_outline, valor: '${widget.pontuacao}', rotulo: t('acertos'), cor: Colors.green),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              if (novoRecorde)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Colors.amber, Colors.orange]),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color: Colors.orange.withOpacity(0.4), blurRadius: 8, offset: const Offset(0, 4))],
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.star, color: Colors.white, size: 30),
                      const SizedBox(height: 5),
                      Text(t('novo_recorde'), style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E3192),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 3,
                  ),
                  icon: const Icon(Icons.home),
                  label: Text(t('voltar'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EstatisticaItem extends StatelessWidget {
  final IconData icone;
  final String valor;
  final String rotulo;
  final Color cor;

  const _EstatisticaItem({required this.icone, required this.valor, required this.rotulo, required this.cor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icone, color: cor, size: 32),
        const SizedBox(height: 8),
        Text(valor, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
        Text(rotulo, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}