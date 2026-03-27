import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'farm_details_screen.dart';
import 'plantacao_screen.dart'; // IMPORT NOVO
import 'add_farm_screen.dart'; // IMPORT NOVO
import 'theme_notifier.dart';
import 'test_sensores_screen.dart';

/// Arquivo: main.dart
/// Ponto de entrada da aplicação. Configura temas, rotas iniciais e
/// insere `ValueListenableBuilder` para ouvir as mudanças de tema.

void main() {
  runApp(const SmartFarmApp());
}

class SmartFarmApp extends StatelessWidget {
  const SmartFarmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, ThemeMode currentMode, _) {
        return MaterialApp(
          title: 'SmartFarm App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: currentMode,
          initialRoute: '/',
          routes: {
            '/': (context) => const HomeScreen(),
            '/farm_details': (context) =>
                const FarmDetailsScreen(), // ROTA RENOMEADA
            '/plantacao': (context) => const PlantacaoScreen(),
            '/add_farm': (context) => const AddFarmScreen(),
            '/test_sensores': (context) =>
                const TestSensoresScreen(), // <-- NOVA ROTA
          },
        );
      },
    );
  }
}
