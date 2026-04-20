import 'package:flutter/material.dart';
import 'styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              // Logótipo SF
              Center(
                child: Container(
                  width: 100, height: 100,
                  decoration: BoxDecoration(color: AppColors.primaryGreen, borderRadius: BorderRadius.circular(25)),
                  child: const Center(child: Text("SF", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold))),
                ),
              ),
              const SizedBox(height: 50),
              Text("Bem-vindo de volta", style: AppTextStyles.title.copyWith(fontSize: 24)),
              const SizedBox(height: 10),
              const Text("Faça login na sua Smart Farm", style: AppTextStyles.greeting),
              const SizedBox(height: 40),

              // Campos de Input
              _buildTextField(label: "E-mail", icon: Icons.email_outlined, controller: _emailController, isDark: isDark),
              const SizedBox(height: 20),
              _buildTextField(label: "Senha", icon: Icons.lock_outline, isPassword: true, controller: _passwordController, isDark: isDark),
              const SizedBox(height: 15),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(onPressed: () {}, child: const Text("Esqueceu a senha?", style: TextStyle(color: AppColors.primaryGreen))),
              ),
              const SizedBox(height: 30),

              // Botão Principal
              SizedBox(
                width: double.infinity, height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGreen,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 0,
                  ),
                  onPressed: () => Navigator.pushReplacementNamed(context, '/home'), // Vai para a Home!
                  child: const Text("Entrar", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, required IconData icon, bool isPassword = false, required TextEditingController controller, required bool isDark}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.primaryGreen),
        filled: true,
        fillColor: isDark ? Colors.grey[800] : Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: Colors.grey.withAlpha((0.2 * 255).round()), width: 1)),
      ),
    );
  }
}