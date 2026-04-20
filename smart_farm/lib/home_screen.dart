import 'package:flutter/material.dart';
import 'custom_app_bar.dart';
import 'farm_state.dart';
import 'styles.dart';

/// Tela principal do aplicativo que exibe a lista de SmartFarms e um resumo
/// dos sensores de cada farm.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// Índice selecionado na barra de navegação inferior.
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Determina se o tema atual é escuro para ajustar cores locais.
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : AppColors.background,
      appBar: const CustomAppBar(),
      body: AnimatedBuilder(
        animation: globalFarmManager,
        builder: (context, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // CABEÇALHO E PESQUISA
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Olá, LITA\nBom Dia",
                        style: AppTextStyles.greeting,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Nurture Plants.",
                        style: AppTextStyles.title.copyWith(
                          color: isDark ? Colors.white : AppColors.textMain,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Barra de Pesquisa com Botão de Filtro (Figma Style)
                      Container(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 8,
                          top: 4,
                          bottom: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.grey[800] : Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: kCardShadows,
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            icon: const Icon(
                              Icons.search,
                              color: AppColors.textSecondary,
                            ),
                            hintText: "Pesquisar planta...",
                            border: InputBorder.none,
                            // Botão de Filtro Verde
                            suffixIcon: Container(
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: AppColors.primaryGreen,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.tune,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // LISTA DE SMARTFARMS
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    "Minhas Plantas",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                const SizedBox(height: 15),

                SizedBox(
                  height: 260, // Altura aumentada para assemelhar à imagem
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    scrollDirection: Axis.horizontal,
                    itemCount: globalFarmManager.farms.length + 1,
                    itemBuilder: (context, index) {
                      if (index == globalFarmManager.farms.length) {
                        return _buildAddFarmCard(context);
                      }
                      final farm = globalFarmManager.farms[index];
                      return AnimatedBuilder(
                        animation: farm,
                        builder: (context, child) =>
                            _buildPlantCard(context, farm, isDark),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30),

                // SENSORES (Visão Geral)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    "Visão Geral",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                const SizedBox(height: 15),
                ...globalFarmManager.farms.map(
                  (farm) => AnimatedBuilder(
                    animation: farm,
                    builder: (ctx, _) => _buildSensorSummaryTile(farm, isDark),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
          if (index == 1) {
            Navigator.pushNamed(context, '/plantacao');
          }
        },
        selectedItemColor: AppColors.primaryGreen,
        unselectedItemColor: Colors.grey,
        backgroundColor: isDark ? Colors.grey[900] : Colors.white,
        elevation: 10,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner, size: 32),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }

  /// Constrói o cartão de planta para a lista horizontal de farms.
  ///
  /// `farm` fornece os dados exibidos e `isDark` controla o estilo visual.
  Widget _buildPlantCard(BuildContext context, FarmState farm, bool isDark) {
    final String imageUrl = kPlantImageUrlSmall;
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, '/farm_details', arguments: farm),
      child: Container(
        width: 170,
        margin: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[800] : Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: kCardShadows,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(25),
                ),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          farm.nome,
                          style: AppTextStyles.cardTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          farm.planta,
                          style: AppTextStyles.cardSubtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.water_drop,
                              size: 16,
                              color: AppColors.water,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "${farm.umidade.toInt()}%",
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          farm.estadoPlanta == 'Ótima'
                              ? Icons.check_circle
                              : Icons.warning,
                          size: 18,
                          color: farm.estadoPlanta == 'Ótima'
                              ? AppColors.primaryGreen
                              : AppColors.warning,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Constrói o cartão que permite adicionar uma nova SmartFarm.
  ///
  /// Navega para a rota `/add_farm` quando tocado.
  Widget _buildAddFarmCard(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/add_farm'),
      child: Container(
        width: 170,
        margin: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[800] : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: AppColors.primaryGreen.withAlpha((0.5 * 255).round()),
            width: 2,
          ),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, size: 40, color: AppColors.primaryGreen),
            SizedBox(height: 10),
            Text(
              "Nova Planta",
              style: TextStyle(
                color: AppColors.primaryGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Constrói um tile resumido com informações principais dos sensores da
  /// `farm` para exibição na lista "Visão Geral".
  Widget _buildSensorSummaryTile(FarmState farm, bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: kCardShadows,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.lightGreen,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(Icons.thermostat, color: AppColors.primaryGreen),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  farm.nome,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "pH: ${farm.ph.toStringAsFixed(1)} | Água: ${farm.nivelAgua}",
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "${farm.temperatura.toStringAsFixed(1)}°",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: AppColors.primaryGreen,
            ),
          ),
        ],
      ),
    );
  }
}
