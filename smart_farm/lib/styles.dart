import 'package:flutter/material.dart';

/// Definições centrais de cores usadas pela aplicação.
///
/// Mantém constantes que representam a paleta principal (inspirada no Figma)
/// para uso consistente em widgets e temas.
class AppColors {
  static const Color primaryGreen = Color(0xFF4CAF50);
  static const Color darkGreen = Color(0xFF2E7D32);
  static const Color lightGreen = Color(0xFFE8F5E9);

  static const Color background = Color(0xFFF9F9F9);
  static const Color textMain = Color(0xFF1E1E1E);
  static const Color textSecondary = Color(0xFF757575);

  static const Color warning = Color(0xFFFFA000);
  static const Color danger = Color(0xFFD32F2F);
  static const Color water = Color(0xFF29B6F6);
}

/// Tipografias padrão da aplicação.
///
/// Agrega `TextStyle` reutilizáveis para títulos, cartões e textos de
/// saudação para garantir consistência visual.
class AppTextStyles {
  static const TextStyle greeting = TextStyle(
    fontSize: 16,
    color: AppColors.textSecondary,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle title = TextStyle(
    fontSize: 28,
    color: AppColors.textMain,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
  );

  static const TextStyle cardTitle = TextStyle(
    fontSize: 16,
    color: AppColors.textMain,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle cardSubtitle = TextStyle(
    fontSize: 13,
    color: AppColors.textSecondary,
  );
}

/// Raio padrão para os cartões da UI.
const double kCardRadius = 15.0;

/// `BorderRadius` reutilizável construído a partir de `kCardRadius`.
final BorderRadius kCardBorderRadius = BorderRadius.circular(kCardRadius);

/// Sombra padrão utilizada em `AppCard` e outros componentes.
const List<BoxShadow> kCardShadows = [
  BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.05),
    blurRadius: 10,
    offset: Offset(0, 4),
  ),
];

/// URLs de imagens usadas como placeholders para plantas.
const String kPlantImageUrlSmall =
    'https://images.unsplash.com/photo-1597848212624-a19eb35e2651?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80';
const String kPlantImageUrlLarge =
    'https://images.unsplash.com/photo-1597848212624-a19eb35e2651?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80';

/// Helper para detectar se o tema atual é escuro.
bool isDarkMode(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark;
