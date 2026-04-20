import 'package:flutter/material.dart';

/// Modelo que representa o estado de uma SmartFarm individual.
///
/// Estende `ChangeNotifier` para notificar ouvintes quando qualquer valor
/// associado à farm for atualizado (temperatura, umidade, pH, etc.).
class FarmState extends ChangeNotifier {
  /// Identificador único da farm.
  String id;

  /// Nome da farm exibido na UI.
  String nome;

  /// Tipo de planta cultivada.
  String planta;

  /// Temperatura atual simulada (°C).
  double temperatura = 24.0;

  /// Umidade do solo simulada (%).
  double umidade = 65.0;

  /// pH do solo simulada.
  double ph = 6.2;

  /// Luminosidade simulada (LDR) em %.
  double luminosidade = 80.0;

  /// Nível do reservatório de água: 'BAIXO'|'MÉDIO'|'ALTO'.
  String nivelAgua = 'ALTO';

  /// Estado geral da planta (avaliado por IA/simulação), por exemplo 'Ótima'.
  String estadoPlanta = 'Ótima';

  FarmState({required this.id, required this.nome, required this.planta});

  /// Atualiza campos fornecidos e notifica ouvintes.
  ///
  /// Parâmetros opcionais permitem atualizar apenas os campos necessários
  /// sem recriar o objeto.
  void atualizar({
    String? novoNome,
    String? novaPlanta,
    double? temp,
    double? umid,
    double? novoPh,
    double? luz,
    String? agua,
    String? estado,
  }) {
    if (novoNome != null) nome = novoNome;
    if (novaPlanta != null) planta = novaPlanta;
    if (temp != null) temperatura = temp;
    if (umid != null) umidade = umid;
    if (novoPh != null) ph = novoPh;
    if (luz != null) luminosidade = luz;
    if (agua != null) nivelAgua = agua;
    if (estado != null) estadoPlanta = estado;
    notifyListeners();
  }
}

/// Gerenciador global de farms usado para armazenar e manipular a lista
/// de `FarmState` da aplicação.
class FarmManager extends ChangeNotifier {
  /// Lista de farms atualmente registradas na aplicação.
  List<FarmState> farms = [
    FarmState(id: '1', nome: 'SmartFarm 1', planta: 'Peace Lily'),
  ];

  /// Adiciona uma nova farm com `nome` e `planta`.
  void addFarm(String nome, String planta) {
    final newId = DateTime.now().millisecondsSinceEpoch.toString();
    farms.add(FarmState(id: newId, nome: nome, planta: planta));
    notifyListeners();
  }

  /// Remove a farm pelo `id` e notifica ouvintes.
  void removerFarm(String id) {
    farms.removeWhere((farm) => farm.id == id);
    notifyListeners();
  }
}

/// Instância global de `FarmManager` usada em toda a aplicação para
/// consultar e modificar as farms.
final FarmManager globalFarmManager = FarmManager();
