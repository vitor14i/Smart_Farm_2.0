import 'package:flutter/material.dart';

/// Arquivo: plantacao_screen.dart
/// Tela com visualização da plantação, análise em tempo real (mock) e
/// recomendações. Contém cards e exemplos de UI para dados de IA.
class PlantacaoScreen extends StatelessWidget {
  const PlantacaoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detalhes da Plantação",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).iconTheme.color,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Câmera ao vivo com IA
            const Text(
              "Análise em Tempo Real (IA)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                height: 250,
                width: double.infinity,
                color: Colors.black87,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      'https://images.unsplash.com/photo-1518531933037-91b2f5f229cc?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[800],
                        child: const Center(
                          child: Icon(
                            Icons.broken_image,
                            size: 48,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ),
                    Container(color: Color.fromRGBO(0, 0, 0, 0.35)),
                    const Center(
                      child: Icon(
                        Icons.center_focus_weak,
                        size: 60,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Card de Saúde da Planta
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green[400]!, Colors.green[700]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Row(
                children: [
                  Icon(Icons.health_and_safety, color: Colors.white, size: 40),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Saúde Foliar: Excelente",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Nenhuma praga ou deficiência nutricional detectada pela IA.",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Cuidados Agrícolas e Dicas
            const Text(
              "Cuidados e Recomendações",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildDicaCard(
              context,
              Icons.water_drop,
              "Irrigação Automatizada",
              "A bomba d'água foi ativada há 2 horas. O solo está com umidade ideal.",
              Colors.blue,
            ),
            const SizedBox(height: 10),
            _buildDicaCard(
              context,
              Icons.science,
              "Nível de pH",
              "O pH atual é 6.2 (Ideal para morangos). Mantenha a nutrição atual.",
              Colors.orange,
            ),
            const SizedBox(height: 10),
            _buildDicaCard(
              context,
              Icons.calendar_month,
              "Previsão de Colheita",
              "Os frutos estarão prontos para coleta em aproximadamente 2 dias.",
              Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDicaCard(
    BuildContext context,
    IconData icon,
    String title,
    String desc,
    MaterialColor color,
  ) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, isDark ? 0.3 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withAlpha((0.2 * 255).round()),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
