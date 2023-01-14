import 'package:flutter/material.dart';
import 'package:to_do_app/view/add/add_page.dart';
import 'package:to_do_app/view/home/home.dart';
import 'package:to_do_app/view/sign_in/sgin_in_page.dart';
import 'package:to_do_app/view/sign_up/sign_up_page.dart';
import 'package:to_do_app/view/splash/splash.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashPage(),
      routes: {
        '/home': (_) => const Home(),
        '/signin': (_) => const SignInPage(),
        '/signup': (_) => const SignUpPage(),
        '/add': (_) => const AddPage(),
      },
    );
  }
}
