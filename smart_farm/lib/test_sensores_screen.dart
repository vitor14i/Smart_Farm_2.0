import 'package:flutter/material.dart';
import 'custom_app_bar.dart';
import 'styles.dart';

/// Arquivo: test_sensores_screen.dart
/// Tela para simular leituras de sensores (temperatura, umidade, pH e nível
/// de água). Útil para testar a interface e integração sem hardware.

class TestSensoresScreen extends StatefulWidget {
  const TestSensoresScreen({super.key});

  @override
  State<TestSensoresScreen> createState() => _TestSensoresScreenState();
}

class _TestSensoresScreenState extends State<TestSensoresScreen> {
  // Valores iniciais simulados dos sensores
  double _temperatura = 24.0;
  double _umidade = 65.0;
  double _ph = 6.2;
  String _nivelAgua = 'ALTO';

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color cardColor = isDark ? Colors.grey[900]! : Colors.white;

    return Scaffold(
      appBar: const CustomAppBar(title: "Simulador de Sensores"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Painel de Testes (ESP32 Virtual)",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Utilize os controlos abaixo para simular as leituras de hardware da sua SmartFarm.",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),

            // Simulador de Temperatura
            _buildSimuladorCard(
              cardColor,
              titulo:
                  "Temperatura Ambiente: ${_temperatura.toStringAsFixed(1)}°C",
              icone: Icons.thermostat,
              corIcone: _temperatura > 30 ? Colors.red : Colors.orange,
              controlo: Slider(
                value: _temperatura,
                min: 10.0,
                max: 45.0,
                divisions: 35,
                activeColor: Colors.orange,
                label: "${_temperatura.toStringAsFixed(1)}°C",
                onChanged: (val) => setState(() => _temperatura = val),
              ),
            ),
            const SizedBox(height: 20),

            // Simulador de Humidade do Solo
            _buildSimuladorCard(
              cardColor,
              titulo: "Humidade do Solo: ${_umidade.toInt()}%",
              icone: Icons.water_drop,
              corIcone: _umidade < 30 ? Colors.red : Colors.blue,
              controlo: Slider(
                value: _umidade,
                min: 0.0,
                max: 100.0,
                divisions: 20,
                activeColor: Colors.blue,
                label: "${_umidade.toInt()}%",
                onChanged: (val) => setState(() => _umidade = val),
              ),
            ),
            const SizedBox(height: 20),

            // Simulador de pH
            _buildSimuladorCard(
              cardColor,
              titulo: "pH do Solo: ${_ph.toStringAsFixed(1)}",
              icone: Icons.science,
              corIcone: (_ph < 5.5 || _ph > 7.5) ? Colors.red : Colors.green,
              controlo: Slider(
                value: _ph,
                min: 0.0,
                max: 14.0,
                divisions: 28,
                activeColor: Colors.green,
                label: _ph.toStringAsFixed(1),
                onChanged: (val) => setState(() => _ph = val),
              ),
            ),
            const SizedBox(height: 20),

            // Simulador de Nível de Água (Reservatório)
            _buildSimuladorCard(
              cardColor,
              titulo: "Reservatório de Água: $_nivelAgua",
              icone: Icons.waves,
              corIcone: _nivelAgua == 'BAIXO' ? Colors.red : Colors.cyan,
              controlo: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: 'BAIXO', label: Text('Baixo')),
                    ButtonSegment(value: 'MÉDIO', label: Text('Médio')),
                    ButtonSegment(value: 'ALTO', label: Text('Alto')),
                  ],
                  selected: {_nivelAgua},
                  onSelectionChanged: (Set<String> newSelection) {
                    setState(() {
                      _nivelAgua = newSelection.first;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Botão para simular envio para o Firebase/MQTT
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.send, color: Colors.white),
                label: const Text(
                  "Simular Envio de Dados",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Dados simulados enviados com sucesso!'),
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

  Widget _buildSimuladorCard(
    Color bgColor, {
    required String titulo,
    required IconData icone,
    required Color corIcone,
    required Widget controlo,
  }) {
    // Card visual que agrupa um controle de simulação (Slider/SegmentedButton)
    // com título e ícone.
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: kCardBorderRadius,
        boxShadow: kCardShadows,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icone, color: corIcone, size: 28),
              const SizedBox(width: 10),
              Text(
                titulo,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          controlo, // Aqui entra o Slider ou o SegmentedButton
        ],
      ),
    );
  }
}
