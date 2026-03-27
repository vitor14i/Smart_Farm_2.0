import 'package:flutter/material.dart';

/// Arquivo: theme_notifier.dart
/// Mantém o estado global do tema (claro / escuro) usado pela aplicação.
/// `themeNotifier` é um `ValueNotifier<ThemeMode>` lido por widgets que
/// precisam reagir à mudança de tema.
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);
