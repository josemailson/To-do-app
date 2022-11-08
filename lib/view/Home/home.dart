import 'dart:async';

import 'package:flutter/material.dart';
import 'package:to_do_app/controller/home_controller.dart';
import 'package:to_do_app/model/to_do_model.dart';
import 'package:to_do_app/repository/home_repository.dart';

import '../add/add_page.dart';
import '../edit/edit_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final homeController = HomeController(HomeRepositoryHttp());
  int id = 0;
  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    void refreshData() {
      id++;
    }

    FutureOr onGoBack(dynamic value) {
      refreshData();
      setState(() {});
    }

    void navigateAddPage() {
      Route route = MaterialPageRoute(builder: (context) => const AddPage());
      Navigator.push(context, route).then(onGoBack);
    }

    void navigateEditPage(id, isDone, title, description) {
      Route route = MaterialPageRoute(
          builder: (context) => EditPage(
              id: id, isDone: isDone, title: title, description: description));
      Navigator.push(context, route).then(onGoBack);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do List'),
        actions: [
          IconButton(
              // ignore: unnecessary_new
              onPressed: () async => navigateAddPage(),
              icon: const Icon(Icons.add))
        ],
      ),
      body: FutureBuilder<List<ToDoModel>>(
        future: homeController.getToDos(),
        builder: ((context, snapshot) {
          if (snapshot.data == null && !snapshot.hasError) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            const Center(
              child: Text('Ops, deu ruim!'),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                final todo = snapshot.data?[index];
                return ListTile(
                  leading: Checkbox(
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: todo?.isDone,
                      onChanged: (bool? value) async {
                        final result = await homeController.editToDo(
                            todo!.id!,
                            ToDoModel(
                                title: todo.title,
                                description: todo.description,
                                isDone: value!));
                        if (result) {
                          setState(() {
                            isDone = value;
                          });
                        }
                      }),
                  title: GestureDetector(
                      child: Text(todo?.title ?? ''),
                      onTap: () async => navigateEditPage(todo?.id,
                          todo?.isDone, todo?.title, todo?.description)),
                  subtitle: GestureDetector(
                      child: Text(todo?.description ?? ''),
                      onTap: () async => navigateEditPage(todo?.id,
                          todo?.isDone, todo?.title, todo?.description)),
                  trailing: IconButton(
                      onPressed: () async {
                        final result =
                            await homeController.deleteToDo(todo!.id!);
                        if (result) {
                          setState(() {});
                        }
                      },
                      icon: const Icon(Icons.delete)),
                );
              });
        }),
      ),
    );
  }
}
