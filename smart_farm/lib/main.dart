import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'home_screen.dart';
import 'farm_details_screen.dart';
import 'plantacao_screen.dart';
import 'add_farm_screen.dart';
import 'theme_notifier.dart';
import 'test_sensores_screen.dart';

/// Ponto de entrada da aplicação.
///
/// Chama `runApp` para inicializar a árvore de widgets com a instância de
/// `SmartFarmApp` que configura rotas e tema da aplicação.
void main() {
  runApp(const SmartFarmApp());
}

/// Widget raiz da aplicação que configura tema, rotas e inicialização.
///
/// Usa `ValueListenableBuilder` observando `themeNotifier` para alternar
/// dinamicamente entre `ThemeMode.light` e `ThemeMode.dark` conforme o usuário
/// altera o tema global da aplicação.
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
          // Rota inicial e mapeamento de telas da aplicação
          initialRoute: '/',
          routes: {
            '/': (context) => const LoginScreen(),
            '/home': (context) => const HomeScreen(),
            '/farm_details': (context) => const FarmDetailsScreen(),
            '/plantacao': (context) => const PlantacaoScreen(),
            '/add_farm': (context) => const AddFarmScreen(),
            '/test_sensores': (context) => const TestSensoresScreen(),
          },
        );
      },
    );
  }
}
