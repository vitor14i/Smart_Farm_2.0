import 'package:flutter/material.dart';
import 'styles.dart';

class PlantacaoScreen extends StatelessWidget {
  const PlantacaoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
                'https://images.unsplash.com/photo-1550989460-0adf9ea622e2?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
                fit: BoxFit.cover,
                color: Colors.black.withAlpha((0.4 * 255).round()),
                colorBlendMode: BlendMode.darken,
              ),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(decoration: BoxDecoration(color: Colors.white.withAlpha((0.2 * 255).round()), shape: BoxShape.circle), child: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context))),
                      const Text("Análise de IA", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),
                Container(
                  width: 250, height: 250,
                  decoration: BoxDecoration(border: Border.all(color: AppColors.primaryGreen, width: 3), borderRadius: BorderRadius.circular(20)),
                  child: Center(child: Icon(Icons.filter_center_focus, size: 50, color: AppColors.primaryGreen.withAlpha((0.5 * 255).round()))),
                ),
                Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[900] : Colors.white, borderRadius: const BorderRadius.vertical(top: Radius.circular(40))),
                  child: Column(
                    children: [
                      const Text("Faça o scan da folha", style: AppTextStyles.title),
                      const SizedBox(height: 10),
                      const Text("Alinhe a folha da sua planta no centro do quadrado para a IA analisar.", textAlign: TextAlign.center, style: TextStyle(color: AppColors.textSecondary)),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: 80, height: 80,
                        child: FloatingActionButton(
                          backgroundColor: AppColors.primaryGreen, elevation: 10, shape: const CircleBorder(),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Análise concluída: Planta saudável!'), backgroundColor: Colors.green));
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.camera_alt, size: 40, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}