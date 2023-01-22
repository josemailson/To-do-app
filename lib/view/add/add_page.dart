import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/controller/add_controller.dart';
import 'package:to_do_app/repository/add_repository.dart';
import 'package:to_do_app/view/add/add_state.dart';
import '../../controller/home_controller.dart';
import '../../repository/home_firebase_repository.dart';
import '../../repository/sign_in_repository.dart';
import '../../services/injection.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final controller =
      AddToDoController(getIt.get<AuthRepository>(), AddToDoRepository());
  final homeController = HomeController(getIt.get<AuthRepository>(),
      HomeFirebaseRepository(FirebaseFirestore.instance));

  @override
  void initState() {
    super.initState();
    controller.notifier.addListener(() {
      if (controller.state is AddToDoSuccessState) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (route) => false);
      }
    });
    homeController.getToDos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Adicionar'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(hintText: 'Título'),
              ),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(hintText: 'Descrição'),
              ),
              ElevatedButton(
                  onPressed: () {
                    controller.addToDo(
                        titleController.text, descriptionController.text);
                  },
                  child: const Text('Adicionar'))
            ],
          )),
        ));
  }
}
