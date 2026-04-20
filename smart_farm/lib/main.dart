import 'package:flutter/material.dart';
import 'login_screen.dart'; 
import 'home_screen.dart';
import 'farm_details_screen.dart';
import 'plantacao_screen.dart'; 
import 'add_farm_screen.dart'; 
import 'theme_notifier.dart';
import 'test_sensores_screen.dart';

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
          initialRoute: '/', // Inicia no Login
          routes: {
            '/': (context) => const LoginScreen(),
            '/home': (context) => const HomeScreen(), // Rota Home atualizada
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