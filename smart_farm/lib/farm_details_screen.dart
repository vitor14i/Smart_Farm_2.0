import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math; // Necessário para simular a variação de 24h
import 'styles.dart';
import 'custom_app_bar.dart';
import 'farm_state.dart';
import 'common_widgets.dart';

class FarmDetailsScreen extends StatelessWidget {
  /// Tela de detalhes de uma `FarmState` específica.
  ///
  /// Exibe informações, tags dinâmicas e gráficos simulados com base nos
  /// dados da `farm` passada via rota (em `ModalRoute.settings.arguments`).
  const FarmDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = isDarkMode(context);
    final FarmState? farm =
        ModalRoute.of(context)?.settings.arguments as FarmState?;
    final String imageUrl = kPlantImageUrlLarge;

    if (farm == null) {
      return Scaffold(
        backgroundColor: isDark ? Colors.grey[900] : AppColors.background,
        appBar: const CustomAppBar(title: 'Detalhes'),
        body: Center(
          child: Text('Nenhuma farm selecionada', style: AppTextStyles.title),
        ),
      );
    }

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : AppColors.background,
      appBar: CustomAppBar(title: farm.nome, currentFarm: farm),
      body: AnimatedBuilder(
        animation: farm,
        builder: (context, child) {
          // Determina cores condicionais com base nos valores da farm
          Color corTemp = farm.temperatura > 30
              ? Colors.red
              : (farm.temperatura < 15 ? Colors.blue : AppColors.primaryGreen);
          Color corUmid = farm.umidade < 30
              ? Colors.red
              : AppColors.primaryGreen;
          Color corPh = (farm.ph < 5.5 || farm.ph > 7.5)
              ? Colors.red
              : AppColors.primaryGreen;
          Color corAgua = farm.nivelAgua == 'BAIXO'
              ? Colors.red
              : (farm.nivelAgua == 'MÉDIO'
                    ? Colors.orange
                    : AppColors.primaryGreen);

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              farm.planta,
                              style: AppTextStyles.title.copyWith(fontSize: 28),
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 22,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "4.8 ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: isDark
                                      ? Colors.white
                                      : AppColors.textMain,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Tags dinâmicas mostrando valores principais
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          InfoTag(
                            icon: Icons.wb_sunny_outlined,
                            text: "Luz: ${farm.luminosidade.toInt()}%",
                            color: Colors.amber,
                          ),
                          InfoTag(
                            icon: Icons.water_drop_outlined,
                            text:
                                "Reservatório: ${farm.nivelAgua.toLowerCase()}",
                            color: corAgua,
                          ),
                          InfoTag(
                            icon: Icons.thermostat,
                            text: "${farm.temperatura.toStringAsFixed(1)}°C",
                            color: corTemp,
                          ),
                          InfoTag(
                            icon: Icons.water,
                            text: "Umid: ${farm.umidade.toInt()}%",
                            color: corUmid,
                          ),
                          InfoTag(
                            icon: Icons.science,
                            text: "pH: ${farm.ph.toStringAsFixed(1)}",
                            color: corPh,
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      Text(
                        "Visão Gráfica (Últimas 24h)",
                        style: AppTextStyles.title.copyWith(fontSize: 22),
                      ),
                      const SizedBox(height: 15),

                      _buildReservoirCard(farm.nivelAgua, isDark),
                      const SizedBox(height: 15),

                      _buildLineChartCard(
                        "Humidade do solo",
                        farm.umidade,
                        100,
                        corUmid,
                        isDark,
                      ),
                      const SizedBox(height: 15),

                      _buildLineChartCard(
                        "Temperatura",
                        farm.temperatura,
                        50,
                        corTemp,
                        isDark,
                      ),
                      const SizedBox(height: 30),

                      Text(
                        "About",
                        style: AppTextStyles.title.copyWith(fontSize: 22),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "${farm.planta} são plantas incríveis para interiores. Atualmente, a IA indica que o estado dela é '${farm.estadoPlanta}'.",
                        style: const TextStyle(
                          fontSize: 15,
                          color: AppColors.textSecondary,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 40),

                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isDark
                                ? Colors.grey[800]
                                : const Color(0xFF1E1E1E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 0,
                          ),
                          onPressed: () =>
                              Navigator.pushNamed(context, '/plantacao'),
                          icon: const Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.white,
                          ),
                          label: const Text(
                            "Scan da Planta (IA)",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Constrói um cartão visualizando o nível do reservatório com barras
  /// e percentual estimado.
  Widget _buildReservoirCard(String level, bool isDark) {
    Color barColor = level == 'ALTO'
        ? AppColors.primaryGreen
        : (level == 'MÉDIO' ? Colors.orange : Colors.red);
    int activeBars = level == 'ALTO' ? 4 : (level == 'MÉDIO' ? 2 : 1);
    String percent = level == 'ALTO'
        ? '100%'
        : (level == 'MÉDIO' ? '50%' : '15%');

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF121625) : Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: kCardShadows,
        border: Border.all(
          color: isDark ? Colors.grey[800]! : Colors.grey[300]!,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Nível reservatório",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                percent,
                style: TextStyle(
                  color: barColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Column(
            children: List.generate(4, (index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 4),
                height: 12,
                decoration: BoxDecoration(
                  color: index >= (4 - activeBars)
                      ? barColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: index >= (4 - activeBars)
                        ? Colors.transparent
                        : Colors.grey.withAlpha((0.3 * 255).round()),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  // GRÁFICO VARIÁVEL (Atualizado para escala de 24 horas)
  Widget _buildLineChartCard(
    String title,
    double currentValue,
    double maxY,
    Color lineColor,
    bool isDark,
  ) {
    // Gerar 24 pontos que variam suavemente e terminam no valor atual do simulador
    final List<FlSpot> spots = List.generate(25, (i) {
      if (i == 24) return FlSpot(24, currentValue);
      final double variacao = currentValue * (0.8 + 0.2 * math.sin(i * 0.5));
      return FlSpot(i.toDouble(), variacao);
    });

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF121625) : Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: kCardShadows,
        border: Border.all(
          color: isDark ? Colors.grey[800]! : Colors.grey[300]!,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                currentValue.toStringAsFixed(1),
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ), // Um pouco mais de espaço para os labels do eixo X
          SizedBox(
            height: 70,
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: 24, // Escala fixa de 24 horas
                minY: 0,
                maxY: maxY,
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                // Títulos para o eixo X (Horas)
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 20,
                      interval: 6, // Mostra os rótulos de 6 em 6 horas
                      getTitlesWidget: (value, meta) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            "${value.toInt()}h",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots, // Os nossos 24 pontos simulados
                    isCurved: true,
                    color: lineColor,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
