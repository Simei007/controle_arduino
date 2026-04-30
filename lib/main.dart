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
  List dispositivos = [];

  @override
  void initState() {
    super.initState();
    listar();
  }

  Future<void> listar() async {
    final res = await platform.invokeMethod('list');
    setState(() => dispositivos = res);
  }

  Future<void> conectar(String mac) async {
    await platform.invokeMethod('connect', {"mac": mac});
    setState(() => conectado = true);
  }

  Future<void> enviar(String c) async {
    if (!conectado) return;
    await platform.invokeMethod('send', {"data": c});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(title: const Text("Casa Inteligente")),
        body: Column(
          children: [

            // STATUS
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(12),
              color: conectado ? Colors.green : Colors.red,
              child: Text(
                conectado ? "Conectado" : "Desconectado",
                style: const TextStyle(color: Colors.white),
              ),
            ),

            // LISTA
            Expanded(
              child: ListView.builder(
                itemCount: dispositivos.length,
                itemBuilder: (context, i) {
                  final d = dispositivos[i];
                  return ListTile(
                    title: Text(d['name'], style: TextStyle(color: Colors.white)),
                    subtitle: Text(d['address'], style: TextStyle(color: Colors.grey)),
                    onTap: () => conectar(d['address']),
                  );
                },
              ),
            ),

            // CONTROLES
            if (conectado)
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [

                  _btn("Luz ON", Colors.yellow, () => enviar("A")),
                  _btn("Luz OFF", Colors.orange, () => enviar("B")),

                  _btn("Abrir Porta", Colors.green, () => enviar("C")),
                  _btn("Fechar Porta", Colors.red, () => enviar("D")),

                  _btn("Alarme ON", Colors.purple, () => enviar("E")),
                  _btn("Alarme OFF", Colors.deepPurple, () => enviar("F")),

                  _btn("Vermelho", Colors.red, () => enviar("G")),
                  _btn("Verde", Colors.green, () => enviar("H")),
                  _btn("Azul", Colors.blue, () => enviar("I")),
                  _btn("RGB OFF", Colors.grey, () => enviar("Z")),
                ],
              )
          ],
        ),
      ),
    );
  }

  Widget _btn(String t, Color c, VoidCallback f) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: c),
      onPressed: f,
      child: Text(t),
    );
  }
}