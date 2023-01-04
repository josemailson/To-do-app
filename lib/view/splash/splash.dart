import 'package:flutter/material.dart';
import 'package:to_do_app/controller/splash_controller.dart';
import 'package:to_do_app/repository/sign_in_repository.dart';

import '../../services/injection.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final controller = SplashController(getIt.get<Repository>());
  @override
  void initState() {
    super.initState();
    controller.getUser();
    controller.notifier.addListener(() {
      if (controller.state == SplashState.authenticated) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (route) => false);
      } else {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/signin', (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
