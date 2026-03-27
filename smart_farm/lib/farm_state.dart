import 'package:flutter/material.dart';

/// Arquivo: farm_state.dart
/// Define o modelo de estado `FarmState` para representar uma SmartFarm
/// individual e `FarmManager` para gerenciar uma lista simples de farms.

/// Representa o estado observável de uma única SmartFarm.
class FarmState extends ChangeNotifier {
  String id;
  String nome;
  String planta;
  double temperatura = 24.0;
  double umidade = 65.0;
  double ph = 6.2;
  String nivelAgua = 'ALTO';
  String estadoPlanta = 'Ótima'; // Possíveis: Ótima, Boa, Normal, Ruim, Péssima

  FarmState({required this.id, required this.nome, required this.planta});

  /// Atualiza campos opcionais e notifica ouvintes para rebuilds reativos.
  void atualizar({
    String? novoNome,
    String? novaPlanta,
    double? temp,
    double? umid,
    double? novoPh,
    String? agua,
    String? estado,
  }) {
    if (novoNome != null) nome = novoNome;
    if (novaPlanta != null) planta = novaPlanta;
    if (temp != null) temperatura = temp;
    if (umid != null) umidade = umid;
    if (novoPh != null) ph = novoPh;
    if (agua != null) nivelAgua = agua;
    if (estado != null) estadoPlanta = estado;
    notifyListeners();
  }
}

/// Gerenciador simples em memória de farms. Em apps reais, substituir por
/// persistência/serviço remoto apropriado.
class FarmManager extends ChangeNotifier {
  List<FarmState> farms = [
    FarmState(id: '1', nome: 'SmartFarm 1', planta: 'Morango'),
  ];

  /// Adiciona uma nova farm à lista e notifica ouvintes.
  void addFarm(String nome, String planta) {
    final newId = DateTime.now().millisecondsSinceEpoch.toString();
    farms.add(FarmState(id: newId, nome: nome, planta: planta));
    notifyListeners();
  }

  /// Remove uma farm por `id` e notifica ouvintes.
  void removerFarm(String id) {
    farms.removeWhere((farm) => farm.id == id);
    notifyListeners();
  }
}

/// Instância global simples usada pela UI neste exemplo.
final FarmManager globalFarmManager = FarmManager();
