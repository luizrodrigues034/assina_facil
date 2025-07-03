import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/custom_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Spacer(),

              // Logo/Imagem
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.description_outlined,
                  size: 100,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 40),

              // Título
              const Text(
                'Assina Fácil',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),

              const SizedBox(height: 16),

              // Descrição
              const Text(
                'Gerencie seus documentos PDF de forma simples e segura. Faça upload, visualize e organize todos os seus arquivos em um só lugar.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey, height: 1.5),
              ),

              const SizedBox(height: 60),

              // Botão de Login
              CustomButton(
                text: 'Entrar',
                onPressed: () => context.go('/login'),
              ),

              const SizedBox(height: 16),

              // Botão de Cadastro
              CustomButton(
                text: 'Criar Conta',
                onPressed: () => context.go('/register'),
                backgroundColor: Colors.white,
                textColor: Colors.blue,
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
