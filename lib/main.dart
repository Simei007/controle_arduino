import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const platform = MethodChannel('bluetooth');

  bool conectado = false;

  Future<void> conectar() async {
    try {
      await platform.invokeMethod('connect');
      setState(() => conectado = true);
      _mensagem("Conectado");
    } catch (e) {
      setState(() => conectado = false);
      _mensagem("Erro ao conectar");
    }
  }

  Future<void> enviar(String comando) async {
    if (!conectado) {
      _mensagem("Conecte primeiro");
      return;
    }

    try {
      await platform.invokeMethod('send', {"data": comando});
    } catch (e) {
      _mensagem("Erro ao enviar");
    }
  }

  void _mensagem(String texto) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(texto)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF0F172A),
        appBar: AppBar(
          title: const Text("Painel Arduino"),
          centerTitle: true,
          backgroundColor: const Color(0xFF020617),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // 🔵 STATUS
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: conectado ? Colors.green : Colors.red,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    conectado ? Icons.check_circle : Icons.error,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    conectado ? "Conectado" : "Desconectado",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),

            // 🔗 BOTÃO CONECTAR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton.icon(
                onPressed: conectar,
                icon: const Icon(Icons.bluetooth),
                label: const Text("Conectar"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // 🎛️ CONTROLE
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _botaoAnimado(
                  texto: "LIGAR",
                  cor: Colors.green,
                  icone: Icons.power,
                  onTap: () => enviar("1"),
                ),
                _botaoAnimado(
                  texto: "DESLIGAR",
                  cor: Colors.red,
                  icone: Icons.power_off,
                  onTap: () => enviar("0"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _botaoAnimado({
    required String texto,
    required Color cor,
    required IconData icone,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTapDown: (_) => setState(() {}),
      onTapUp: (_) => setState(() {}),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 140,
        height: 140,
        decoration: BoxDecoration(
          color: cor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: cor.withOpacity(0.6),
              blurRadius: 25,
              spreadRadius: 2,
            ),
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icone, size: 50, color: Colors.white),
              const SizedBox(height: 10),
              Text(
                texto,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}