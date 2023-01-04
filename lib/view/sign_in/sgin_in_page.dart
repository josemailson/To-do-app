import 'package:flutter/material.dart';
import 'package:to_do_app/controller/sign_in_controller.dart';
import 'package:to_do_app/view/sign_in/sign_in_state.dart';

import '../../repository/sign_in_repository.dart';
import '../../services/injection.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final controller = SignInController(getIt.get<AuthRepository>());
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.notifier.addListener(() {
      if (controller.state is ErrorSignInState) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('ops, deu erro no login')));
      }
      if (controller.state is SuccessSignInState) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (route) => false);
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('To Do App'),
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
                                controller.login(emailController.text,
                                    passwordController.text);
                              },
                              child: const Text('Entrar'),
                            );
                    }),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/signup');
                  },
                  child: const Text('Registrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
