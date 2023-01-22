import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../controller/add_controller.dart';
import '../../controller/home_controller.dart';
import '../../model/to_do_model.dart';
import '../../repository/add_repository.dart';
import '../../repository/home_firebase_repository.dart';
import '../../repository/sign_in_repository.dart';
import '../../services/injection.dart';

class EditPage extends StatefulWidget {
  final ToDoModel todo;
  final String title;
  final String description;
  final bool isDone;
  const EditPage(
      {super.key,
      required this.todo,
      required this.title,
      required this.description,
      required this.isDone});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController titleController = TextEditingController();
  late TextEditingController descriptionController = TextEditingController();
  final controller =
      AddToDoController(getIt.get<AuthRepository>(), AddToDoRepository());
  final homeController = HomeController(getIt.get<AuthRepository>(),
      HomeFirebaseRepository(FirebaseFirestore.instance));

  @override
  Widget build(BuildContext context) {
    titleController = TextEditingController(text: widget.title);
    descriptionController = TextEditingController(text: widget.description);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Editar'),
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
                    controller.updateToDo(widget.todo, titleController.text,
                        descriptionController.text, widget.isDone);
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/home', (route) => false);
                  },
                  child: const Text('Editar'))
            ],
          )),
        ));
  }
}
