import 'package:flutter/material.dart';

import '../../controller/home_controller.dart';
import '../../model/to_do_model.dart';
import '../../repository/home_repository.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final homeController = HomeController(HomeRepositoryHttp());
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
                    homeController.createToDo(ToDoModel(
                        title: titleController.text,
                        description: descriptionController.text,
                        isDone: false,
                        date: DateTime.now(),
                        userId: ''));
                    Navigator.pop(context, true);
                  },
                  child: const Text('Adicionar'))
            ],
          )),
        ));
  }
}
