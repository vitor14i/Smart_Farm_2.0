import 'package:flutter/material.dart';
import 'custom_app_bar.dart';
import 'common_widgets.dart';

/// Arquivo: test_sensores_screen.dart
/// Tela para simular leituras de sensores (temperatura, umidade, pH e nível
/// de água). Útil para testar a interface e integração sem hardware.

class TestSensoresScreen extends StatefulWidget {
  const TestSensoresScreen({super.key});

  @override
  /// Cria o objeto `State` associado a esta `StatefulWidget`.
  ///
  /// Retorna uma instância de `_TestSensoresScreenState` que gerencia o
  /// estado e constrói a interface da tela de simulação de sensores.
  State<TestSensoresScreen> createState() => _TestSensoresScreenState();
}

class _TestSensoresScreenState extends State<TestSensoresScreen> {
  /// Estado de `TestSensoresScreen`.
  ///
  /// Mantém valores simulados de temperatura, umidade, pH e nível do
  /// reservatório, usados pelos controles desta tela.

  /// Valor simulado da temperatura em °C.
  double _temperatura = 24.0;

  /// Valor simulado da umidade em %.
  double _umidade = 65.0;

  /// Valor simulado do pH do solo.
  double _ph = 6.2;

  /// Estado simulado do nível do reservatório de água.
  String _nivelAgua = 'ALTO';

  @override
  Widget build(BuildContext context) {
    /// Constrói a tela com controles para ajustar valores simulados dos
    /// sensores e um botão para simular o envio desses dados.

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
            SensorControl(
              title:
                  "Temperatura Ambiente: ${_temperatura.toStringAsFixed(1)}°C",
              icon: Icons.thermostat,
              iconColor: _temperatura > 30 ? Colors.red : Colors.orange,
              control: Slider(
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
            SensorControl(
              title: "Humidade do Solo: ${_umidade.toInt()}%",
              icon: Icons.water_drop,
              iconColor: _umidade < 30 ? Colors.red : Colors.blue,
              control: Slider(
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
            SensorControl(
              title: "pH do Solo: ${_ph.toStringAsFixed(1)}",
              icon: Icons.science,
              iconColor: (_ph < 5.5 || _ph > 7.5) ? Colors.red : Colors.green,
              control: Slider(
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
            SensorControl(
              title: "Reservatório de Água: $_nivelAgua",
              icon: Icons.waves,
              iconColor: _nivelAgua == 'BAIXO' ? Colors.red : Colors.cyan,
              control: Padding(
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
}
