import 'package:flutter/material.dart';
import 'styles.dart';
import 'custom_app_bar.dart';
import 'farm_state.dart';

/// Arquivo: home_screen.dart
/// Tela principal que lista as SmartFarms do usuário e mostra indicadores
/// rápidos como temperatura, nível de água e estado da planta.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Escuta APENAS a lista global para saber se uma farm foi adicionada/removida
    return Scaffold(
      appBar: const CustomAppBar(),
      body: AnimatedBuilder(
        animation: globalFarmManager,
        builder: (context, child) {
          double tempGeral = globalFarmManager.farms.isNotEmpty
              ? globalFarmManager.farms.first.temperatura
              : 24.0;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Olá LITA",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.wb_sunny_outlined, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            "${tempGeral.toStringAsFixed(1)}°C",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),

                // SECÇÃO: Minhas SmartFarms
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Minhas SmartFarms",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      ...globalFarmManager.farms.map(
                        (farm) => AnimatedBuilder(
                          animation:
                              farm, // CORREÇÃO: Escuta cada farm individualmente!
                          builder: (ctx, _) => Container(
                            width: 160,
                            margin: const EdgeInsets.only(right: 15),
                            child: _buildFarmButton(
                              context,
                              farm.nome,
                              farm.planta,
                              Icons.keyboard_arrow_right,
                              "/farm_details",
                              farm,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 160,
                        child: _buildFarmButton(
                          context,
                          "Adicionar",
                          "SmartFarm",
                          Icons.add_box_sharp,
                          "/add_farm",
                          null,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),

                // SECÇÃO NOVO: Estado da Planta
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Estado da Planta",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: globalFarmManager.farms
                        .map(
                          (farm) => AnimatedBuilder(
                            animation: farm,
                            builder: (ctx, _) {
                              List<Color> corEstado =
                                  (farm.estadoPlanta == 'Ótima' ||
                                      farm.estadoPlanta == 'Boa')
                                  ? [Colors.green[400]!, Colors.green[700]!]
                                  : farm.estadoPlanta == 'Normal'
                                  ? [Colors.yellow[600]!, Colors.orange[400]!]
                                  : [Colors.red[400]!, Colors.red[800]!];
                              return Container(
                                width: 160,
                                margin: const EdgeInsets.only(right: 15),
                                child: _buildGradientCard(
                                  farm.estadoPlanta.toUpperCase(),
                                  corEstado,
                                  farm.nome,
                                ),
                              );
                            },
                          ),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(height: 25),

                // SECÇÃO: Nível de Água
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Nível da água no reservatório",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: globalFarmManager.farms
                        .map(
                          (farm) => AnimatedBuilder(
                            animation: farm,
                            builder: (ctx, _) {
                              List<Color> corAgua = farm.nivelAgua == 'BAIXO'
                                  ? [Colors.red[400]!, Colors.red[700]!]
                                  : farm.nivelAgua == 'MÉDIO'
                                  ? [Colors.orange[400]!, Colors.orange[700]!]
                                  : [Colors.blue[200]!, Colors.blue[600]!];
                              return Container(
                                width: 160,
                                margin: const EdgeInsets.only(right: 15),
                                child: _buildGradientCard(
                                  farm.nivelAgua,
                                  corAgua,
                                  farm.nome,
                                ),
                              );
                            },
                          ),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(height: 25),

                // SECÇÃO: Umidade do solo
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Umidade do solo",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: globalFarmManager.farms
                        .map(
                          (farm) => AnimatedBuilder(
                            animation: farm,
                            builder: (ctx, _) {
                              String estadoUmidade = farm.umidade < 30
                                  ? "BAIXA"
                                  : "BOA";
                              List<Color> corUmidade = farm.umidade < 30
                                  ? [Colors.orange[700]!, Colors.orange[400]!]
                                  : [Colors.brown[700]!, Colors.brown[400]!];
                              return Container(
                                width: 160,
                                margin: const EdgeInsets.only(right: 15),
                                child: _buildGradientCard(
                                  estadoUmidade,
                                  corUmidade,
                                  farm.nome,
                                ),
                              );
                            },
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFarmButton(
    BuildContext context,
    String text1,
    String text2,
    IconData icon,
    String? route,
    FarmState? farm,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      onPressed: route != null
          ? () => Navigator.pushNamed(context, route, arguments: farm)
          : () {},
      child: Column(
        children: [
          Text(
            text1,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text(
            text2,
            style: const TextStyle(fontSize: 13),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Icon(icon, size: 27),
        ],
      ),
    );
  }

  Widget _buildGradientCard(
    String status,
    List<Color> colors,
    String farmName,
  ) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: colors,
            ),
            borderRadius: kCardBorderRadius,
          ),
          alignment: Alignment.center,
          child: Text(
            status,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(farmName, overflow: TextOverflow.ellipsis),
      ],
    );
  }
}
