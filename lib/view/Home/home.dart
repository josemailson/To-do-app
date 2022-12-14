import 'dart:async';

import 'package:flutter/material.dart';
import 'package:to_do_app/controller/add_controller.dart';
import 'package:to_do_app/controller/home_controller.dart';
import 'package:to_do_app/repository/home_firebase_repository.dart';
import 'package:to_do_app/repository/sign_in_repository.dart';
import 'package:to_do_app/services/date_extension.dart';
import 'package:to_do_app/services/injection.dart';
import 'package:to_do_app/view/home/home_state.dart';

import '../../repository/add_repository.dart';
import '../add/add_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final controller =
      HomeController(getIt.get<AuthRepository>(), HomeFirebaseRepository());
  final addController =
      AddToDoController(getIt.get<AuthRepository>(), AddToDoRepository());
  int id = 0;
  bool isDone = false;

  @override
  void initState() {
    super.initState();
    controller.notifier.addListener(() {
      if (controller.state is HomeLogoutState) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/signin', (route) => false);
      }
    });
    controller.getToDos();
  }

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
      // Route route = MaterialPageRoute(
      //     builder: (context) => EditPage(
      //         id: id, isDone: isDone, title: title, description: description));
      // Navigator.push(context, route).then(onGoBack);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do List'),
        actions: [
          IconButton(
              onPressed: () async => navigateAddPage(),
              icon: const Icon(Icons.add)),
          IconButton(
              onPressed: () async {
                await controller.signOut();
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: ValueListenableBuilder(
          valueListenable: controller.notifier,
          builder: (context, state, _) {
            if (state is HomeLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is HomeErrorState) {
              return Center(
                child: TextButton(
                  child: const Text('Tentar Novamente'),
                  onPressed: () async {
                    await controller.getToDos();
                  },
                ),
              );
            }
            if (state is HomeSuccessState) {
              return ListView.builder(
                  itemCount: state.todoList.length,
                  itemBuilder: (context, index) {
                    final todo = state.todoList[index];
                    return ExpansionTile(
                      expandedAlignment: Alignment.centerLeft,
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      leading: Checkbox(
                          checkColor: Colors.white,
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: todo.isDone,
                          onChanged: (bool? value) async {
                            // final result = await homeController.editToDo(
                            //     todo!.id!,
                            //     ToDoModel(
                            //         title: todo.title,
                            //         description: todo.description,
                            //         isDone: value!,
                            //         date: todo.date,
                            //         userId: todo.userId));
                            // if (result) {
                            //   setState(() {
                            //     isDone = value;
                            //   });
                            // }
                          }),
                      title: Text(todo.title),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(todo.description),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.edit)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(todo.date.formattedDate),
                              IconButton(
                                  onPressed: () async {
                                    if (todo.id != null) {
                                      controller.deleteToDo(todo.id!);
                                    }
                                  },
                                  icon: const Icon(Icons.delete)),
                            ],
                          ),
                        ),
                      ],
                    );
                  });
            }
            return const SizedBox.shrink();
          }),
    );
  }
}
