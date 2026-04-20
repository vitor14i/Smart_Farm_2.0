import 'package:flutter/material.dart';
import 'theme_notifier.dart';
import 'farm_state.dart';

/// AppBar customizada usada pela maioria das telas da aplicação.
///
/// Permite opcionalmente exibir um título e receber a `currentFarm` para
/// ações contextuais (ex.: abrir o painel do simulador já apontando para a
/// farm atual).
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final FarmState? currentFarm;

  const CustomAppBar({super.key, this.title, this.currentFarm});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != null
          ? Text(title!, style: const TextStyle(fontWeight: FontWeight.bold))
          : null,
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: Theme.of(context).iconTheme.color,
      actions: [
        // Alterna o tema global entre claro/escuro
        IconButton(
          icon: const Icon(Icons.wb_sunny_outlined),
          onPressed: () =>
              themeNotifier.value = themeNotifier.value == ThemeMode.light
              ? ThemeMode.dark
              : ThemeMode.light,
        ),
        // Botão Home: navega para a rota '/home' se não estiver já nela
        IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            if (ModalRoute.of(context)?.settings.name != '/home') {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/home',
                (route) => false,
              );
            }
          },
        ),
        // Abre o painel do simulador (modal bottom sheet)
        IconButton(
          icon: const Icon(Icons.settings_rounded),
          tooltip: "Painel do Simulador",
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => SimuladorPanel(initialFarm: currentFarm),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// Painel modal usado para simular atualizações em tempo real nas farms.
class SimuladorPanel extends StatefulWidget {
  final FarmState? initialFarm;
  const SimuladorPanel({super.key, this.initialFarm});

  @override
  State<SimuladorPanel> createState() => _SimuladorPanelState();
}

class _SimuladorPanelState extends State<SimuladorPanel> {
  FarmState? farmSelecionada;
  final List<String> opcoesEstado = [
    'Ótima',
    'Boa',
    'Normal',
    'Ruim',
    'Péssima',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.initialFarm != null) {
      farmSelecionada = widget.initialFarm;
    } else if (globalFarmManager.farms.isNotEmpty) {
      farmSelecionada = globalFarmManager.farms.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    if (farmSelecionada == null)
      return Container(
        height: 200,
        color: isDark ? Colors.grey[900] : Colors.white,
        child: const Center(child: Text("Adicione uma Farm primeiro!")),
      );

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: AnimatedBuilder(
        animation: farmSelecionada!,
        builder: (context, child) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Simulador em Tempo Real",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                DropdownButton<FarmState>(
                  value: farmSelecionada,
                  isExpanded: true,
                  items: globalFarmManager.farms
                      .map(
                        (farm) => DropdownMenuItem(
                          value: farm,
                          child: Text("Simulando: ${farm.nome}"),
                        ),
                      )
                      .toList(),
                  onChanged: (novoFarm) =>
                      setState(() => farmSelecionada = novoFarm),
                ),
                const Divider(),

                Text(
                  "Temperatura: ${farmSelecionada!.temperatura.toStringAsFixed(1)}°C",
                ),
                Slider(
                  value: farmSelecionada!.temperatura,
                  min: 10,
                  max: 45,
                  activeColor: Colors.orange,
                  onChanged: (val) => farmSelecionada!.atualizar(temp: val),
                ),

                Text("Humidade do Solo: ${farmSelecionada!.umidade.toInt()}%"),
                Slider(
                  value: farmSelecionada!.umidade,
                  min: 0,
                  max: 100,
                  activeColor: Colors.blue,
                  onChanged: (val) => farmSelecionada!.atualizar(umid: val),
                ),

                Text("pH do Solo: ${farmSelecionada!.ph.toStringAsFixed(1)}"),
                Slider(
                  value: farmSelecionada!.ph,
                  min: 0.0,
                  max: 14.0,
                  divisions: 28,
                  activeColor: Colors.green,
                  onChanged: (val) => farmSelecionada!.atualizar(novoPh: val),
                ),

                // Luminosidade (novo sensor) e demais controles do simulador
                Text("Luminosidade: ${farmSelecionada!.luminosidade.toInt()}%"),
                Slider(
                  value: farmSelecionada!.luminosidade,
                  min: 0,
                  max: 100,
                  activeColor: Colors.amber,
                  onChanged: (val) => farmSelecionada!.atualizar(luz: val),
                ),

                const Text(
                  "Estado da Planta (IA):",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  value: farmSelecionada!.estadoPlanta,
                  isExpanded: true,
                  items: opcoesEstado
                      .map(
                        (est) => DropdownMenuItem(value: est, child: Text(est)),
                      )
                      .toList(),
                  onChanged: (val) => farmSelecionada!.atualizar(estado: val),
                ),
                const SizedBox(height: 10),

                Text(
                  "Nível da Água: ${farmSelecionada!.nivelAgua}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: 'BAIXO', label: Text('Baixo')),
                    ButtonSegment(value: 'MÉDIO', label: Text('Médio')),
                    ButtonSegment(value: 'ALTO', label: Text('Alto')),
                  ],
                  selected: {farmSelecionada!.nivelAgua},
                  onSelectionChanged: (Set<String> newSelection) =>
                      farmSelecionada!.atualizar(agua: newSelection.first),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Fechar Painel"),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
