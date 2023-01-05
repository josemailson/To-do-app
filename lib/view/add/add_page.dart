import 'package:flutter/material.dart';
import 'package:to_do_app/controller/add_controller.dart';
import 'package:to_do_app/repository/add_repository.dart';
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
                    Navigator.pop(context, true);
                  },
                  child: const Text('Adicionar'))
            ],
          )),
        ));
  }
}
