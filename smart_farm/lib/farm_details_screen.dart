import 'package:flutter/material.dart';
import 'styles.dart';
import 'custom_app_bar.dart';
import 'farm_state.dart';

/// Arquivo: farm_details_screen.dart
/// Mostra detalhes de uma SmartFarm selecionada, incluindo sensores e
/// estado da planta. Fornece edição rápida do nome/planta via diálogo.
class FarmDetailsScreen extends StatelessWidget {
  const FarmDetailsScreen({super.key});

  /// Abre um diálogo modal para editar `nome` e `planta` da farm.
  void _mostrarDialogEdicao(BuildContext context, FarmState farm) {
    TextEditingController nomeController = TextEditingController(
      text: farm.nome,
    );
    TextEditingController plantaController = TextEditingController(
      text: farm.planta,
    );
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Editar SmartFarm"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(labelText: "Nome da Farm"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: plantaController,
              decoration: const InputDecoration(labelText: "Espécie da Planta"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              farm.atualizar(
                novoNome: nomeController.text,
                novaPlanta: plantaController.text,
              );
              Navigator.pop(ctx);
            },
            child: const Text("Salvar"),
          ),
        ],
      ),
    );
  }

  // Função que gera a mensagem detalhada baseada no Estado da Planta
  Map<String, dynamic> _obterDetalhesEstado(String estado) {
    switch (estado) {
      case 'Ótima':
        return {
          'cor': Colors.green,
          'icone': Icons.star,
          'titulo': 'Parabéns!',
          'msg':
              'Sua planta está em condições ideais de cultivo. Continue com o excelente trabalho!',
        };
      case 'Boa':
        return {
          'cor': Colors.lightGreen,
          'icone': Icons.thumb_up,
          'titulo': 'Tudo Bem!',
          'msg':
              'Sua planta está indo bem. Mantenha as regas e a iluminação em dia para atingir o estado Ótimo.',
        };
      case 'Normal':
        return {
          'cor': Colors.orange,
          'icone': Icons.warning_amber_rounded,
          'titulo': 'Atenção:',
          'msg':
              'A planta está estável, mas pode melhorar. Verifique se o pH e a umidade estão nas faixas ideais para essa espécie.',
        };
      case 'Ruim':
        return {
          'cor': Colors.deepOrange,
          'icone': Icons.error_outline,
          'titulo': 'Alerta:',
          'msg':
              'A planta apresenta sinais de estresse. Verifique imediatamente os níveis de água, pH e umidade do solo.',
        };
      case 'Péssima':
        return {
          'cor': Colors.red,
          'icone': Icons.dangerous,
          'titulo': 'Crítico:',
          'msg':
              'A planta corre risco! Intervenção imediata necessária na nutrição e irrigação para evitar a perda da colheita.',
        };
      default:
        return {
          'cor': Colors.grey,
          'icone': Icons.help_outline,
          'titulo': 'Desconhecido',
          'msg': 'Aguardando análise da IA...',
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final FarmState farm =
        ModalRoute.of(context)!.settings.arguments as FarmState;

    return Scaffold(
      // LIGAÇÃO FEITA: Passamos o 'currentFarm: farm' para a AppBar abrir o simulador na Farm certa!
      appBar: CustomAppBar(title: farm.nome, currentFarm: farm),
      body: AnimatedBuilder(
        animation: farm,
        builder: (context, child) {
          final detalhes = _obterDetalhesEstado(farm.estadoPlanta);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // NOVO: Card Dinâmico de Detalhes do Estado da Planta
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: colorWithOpacity(
                      detalhes['cor'],
                      isDark ? 0.2 : 0.1,
                    ),
                    border: Border.all(color: detalhes['cor'], width: 2),
                    borderRadius: kCardBorderRadius,
                  ),
                  child: Row(
                    children: [
                      Icon(detalhes['icone'], color: detalhes['cor'], size: 40),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Estado: ${farm.estadoPlanta}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: detalhes['cor'],
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              detalhes['titulo'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(detalhes['msg']),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                const Text(
                  "Sensores Atuais",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _buildSensorBox(
                        "Temp.",
                        "${farm.temperatura.toStringAsFixed(1)}°C",
                        farm.temperatura > 30 ? Colors.red : Colors.orange,
                        Icons.thermostat,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildSensorBox(
                        "Humidade",
                        "${farm.umidade.toInt()}%",
                        farm.umidade < 30 ? Colors.red : Colors.blue,
                        Icons.water_drop,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _buildSensorBox(
                        "pH",
                        farm.ph.toStringAsFixed(1),
                        (farm.ph < 5.5 || farm.ph > 7.5)
                            ? Colors.red
                            : Colors.green,
                        Icons.science,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildSensorBox(
                        "Água",
                        farm.nivelAgua,
                        farm.nivelAgua == 'BAIXO'
                            ? Colors.red
                            : farm.nivelAgua == 'MÉDIO'
                            ? Colors.orange
                            : Colors.cyan,
                        Icons.waves,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Botões
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(15),
                          backgroundColor: Colors.green[700],
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () =>
                            Navigator.pushNamed(context, '/plantacao'),
                        icon: const Icon(Icons.center_focus_weak),
                        label: const Text("Análise (IA)"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(15),
                          backgroundColor: Colors.blue[700],
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () => _mostrarDialogEdicao(context, farm),
                        icon: const Icon(Icons.edit),
                        label: const Text("Editar Farm"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Caixa visual para exibir um sensor (título, valor e ícone).
  Widget _buildSensorBox(
    String title,
    String value,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: colorWithOpacity(color, 0.1),
        borderRadius: kCardBorderRadius,
        border: Border.all(color: colorWithOpacity(color, 0.5)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
