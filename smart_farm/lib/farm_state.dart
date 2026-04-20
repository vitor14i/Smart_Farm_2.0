import 'package:flutter/material.dart';

class FarmState extends ChangeNotifier {
  String id;
  String nome;
  String planta;
  double temperatura = 24.0;
  double umidade = 65.0;
  double ph = 6.2;
  double luminosidade = 80.0; // NOVO SENSOR (LDR)
  String nivelAgua = 'ALTO';
  String estadoPlanta = 'Ótima';

  FarmState({required this.id, required this.nome, required this.planta});

  void atualizar({String? novoNome, String? novaPlanta, double? temp, double? umid, double? novoPh, double? luz, String? agua, String? estado}) {
    if (novoNome != null) nome = novoNome;
    if (novaPlanta != null) planta = novaPlanta;
    if (temp != null) temperatura = temp;
    if (umid != null) umidade = umid;
    if (novoPh != null) ph = novoPh;
    if (luz != null) luminosidade = luz; // NOVO
    if (agua != null) nivelAgua = agua;
    if (estado != null) estadoPlanta = estado;
    notifyListeners();
  }
}

class FarmManager extends ChangeNotifier {
  List<FarmState> farms = [
    FarmState(id: '1', nome: 'SmartFarm 1', planta: 'Peace Lily'),
  ];

  void addFarm(String nome, String planta) {
    final newId = DateTime.now().millisecondsSinceEpoch.toString();
    farms.add(FarmState(id: newId, nome: nome, planta: planta));
    notifyListeners();
  }

  void removerFarm(String id) {
    farms.removeWhere((farm) => farm.id == id);
    notifyListeners();
  }
}

final FarmManager globalFarmManager = FarmManager();