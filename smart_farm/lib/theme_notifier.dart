import 'package:flutter/material.dart';

/// Notifier global que armazena o `ThemeMode` atual da aplicação.
///
/// Widgets podem escutar `themeNotifier` (por exemplo via
/// `ValueListenableBuilder`) para reagir quando o usuário alternar entre
/// tema claro e escuro.
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);
