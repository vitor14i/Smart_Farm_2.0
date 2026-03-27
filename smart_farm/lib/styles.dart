import 'package:flutter/material.dart';

/// Arquivo: styles.dart
/// Constantes e utilitários visuais compartilhados pela aplicação (radii,
/// sombras, estilos de texto e helpers de cor).

// Dimensões
const double kCardRadius = 15.0;

// Shadows
const List<BoxShadow> kCardShadows = [
  BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.05),
    blurRadius: 10,
    offset: Offset(0, 4),
  ),
];

// Text styles
const TextStyle kHeaderStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold,
);
const TextStyle kSubtleStyle = TextStyle(color: Colors.grey);
const TextStyle kCardTitleStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

// Common radii
final BorderRadius kCardBorderRadius = BorderRadius.circular(kCardRadius);

// Utility to build a color with alpha from an existing Color without using
// deprecated `.red/.green/.blue` getters.
/// Retorna uma nova `Color` com a opacidade aplicada sobre a cor `c`.
/// Usa operações de bits para extrair canais RGBA e reconstruir com alpha.
Color colorWithOpacity(Color c, double opacity) {
  final int v = c.toARGB32();
  final int r = (v >> 16) & 0xFF;
  final int g = (v >> 8) & 0xFF;
  final int b = v & 0xFF;
  return Color.fromRGBO(r, g, b, opacity);
}
