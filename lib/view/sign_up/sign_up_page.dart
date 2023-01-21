import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../controller/sign_in_controller.dart';
import '../../repository/sign_in_repository.dart';
import '../sign_in/sign_in_state.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final controller =
      SignInController(FirebaseRepository(FirebaseAuth.instance));
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.notifier.addListener(() {
      if (controller.state is ErrorSignInState) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('ops, erro ao criar conta!')));
      }
      if (controller.state is SuccessSignInState) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Conta criada com sucesso! Realize Login.')));
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/signin', (route) => false);
      }
    });
  }

  @override
  void dispose() {
    controller.notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar'),
      ),
      body: Center(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Bem vindo!'),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Senha',
                  ),
                ),
              ),
              ValueListenableBuilder(
                  valueListenable: controller.notifier,
                  builder: (_, state, __) {
                    return (state is LoadingSignInState)
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () {
                              //fazer validações dos campos email e senha
                              controller.register(emailController.text,
                                  passwordController.text);
                            },
                            child: const Text('Registrar'),
                          );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
