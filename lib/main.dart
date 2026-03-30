import 'package:flutter/material.dart';
import 'services/api_service.dart'; // Tu conexión con Dio

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MobileLock AI',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TestConnectionPage(),
    );
  }
}

class TestConnectionPage extends StatefulWidget {
  const TestConnectionPage({super.key});

  @override
  State<TestConnectionPage> createState() => _TestConnectionPageState();
}

class _TestConnectionPageState extends State<TestConnectionPage> {
  String _status = "Esperando para conectar...";
  Color _color = Colors.orange;
  final ApiService _api = ApiService(); 

  Future<void> _checkBackend() async {
    setState(() => _status = "Llamando a Django...");
    try {
      // Intentamos un GET a la raíz del backend
      final response = await _api.dio.get('/'); 
      if (response.statusCode == 200) {
        setState(() {
          _status = "¡Conexión Exitosa con MobileLock AI!";
          _color = Colors.green;
        });
      }
    } catch (e) {
      setState(() {
        _status = "Error: El Backend no responde (¿Está encendido?)";
        _color = Colors.red;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("MobileLock AI - T006")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _color,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(_status, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _checkBackend,
              icon: const Icon(Icons.sync),
              label: const Text("Probar Conexión con Django"),
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12)),
            ),
          ],
        ),
      ),
    );
  }
}