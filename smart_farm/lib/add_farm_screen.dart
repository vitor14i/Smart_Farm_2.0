import 'package:flutter/material.dart';
import 'farm_state.dart';

/// Tela para adicionar uma nova `FarmState` localmente.
///
/// Valida campos e, em caso de sucesso, adiciona a farm ao
/// `globalFarmManager` e fecha a tela.
class AddFarmScreen extends StatefulWidget {
  const AddFarmScreen({super.key});

  @override
  State<AddFarmScreen> createState() => _AddFarmScreenState();
}

class _AddFarmScreenState extends State<AddFarmScreen> {
  final TextEditingController _nomeController = TextEditingController();
  String? plantaSelecionada;
  final List<String> plantasSuportadas = [
    'Morango',
    'Alface',
    'Tomate Cereja',
    'Manjericão',
    'Hortelã',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Nova SmartFarm",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Campo para o nome da nova farm
            TextFormField(
              controller: _nomeController,
              decoration: InputDecoration(
                labelText: 'Nome da SmartFarm',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.edit),
              ),
            ),
            const SizedBox(height: 20),
            // Seletor de planta suportada
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Planta',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.eco),
              ),
              initialValue: plantaSelecionada,
              items: plantasSuportadas
                  .map(
                    (String planta) =>
                        DropdownMenuItem(value: planta, child: Text(planta)),
                  )
                  .toList(),
              onChanged: (val) => setState(() => plantaSelecionada = val),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.check_circle, color: Colors.white),
                label: const Text(
                  "Adicionar SmartFarm",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[600],
                ),
                onPressed: () {
                  // Validação simples: ambos os campos devem estar preenchidos
                  if (_nomeController.text.isNotEmpty &&
                      plantaSelecionada != null) {
                    globalFarmManager.addFarm(
                      _nomeController.text,
                      plantaSelecionada!,
                    );
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Preencha todos os campos!'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
