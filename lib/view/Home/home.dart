import 'package:flutter/material.dart';
import 'package:to_do_app/controller/add_controller.dart';
import 'package:to_do_app/controller/home_controller.dart';
import 'package:to_do_app/repository/home_firebase_repository.dart';
import 'package:to_do_app/repository/sign_in_repository.dart';
import 'package:to_do_app/services/date_extension.dart';
import 'package:to_do_app/services/injection.dart';
import 'package:to_do_app/view/home/home_state.dart';

import '../../repository/add_repository.dart';
import '../edit/edit_page.dart';

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
    void navigateEditPage(todo, title, description, isDone) {
      Route route = MaterialPageRoute(
        builder: (context) => EditPage(
            todo: todo, title: title, description: description, isDone: isDone),
      );
      Navigator.push(context, route);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do List'),
        actions: [
          IconButton(
              onPressed: () async {
                Navigator.of(context).pushNamed('/add');
              },
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
                    return Dismissible(
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.startToEnd) {
                          navigateEditPage(
                              todo, todo.title, todo.description, todo.isDone);
                          return false;
                        } else {
                          if (todo.id != null) {
                            await controller.deleteToDo(todo.id!);
                          }
                        }
                        return true;
                      },
                      key: UniqueKey(),
                      background: Container(
                        padding: const EdgeInsets.only(left: 16),
                        alignment: Alignment.centerLeft,
                        color: Colors.green,
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                      secondaryBackground: Container(
                        padding: const EdgeInsets.only(right: 16),
                        alignment: Alignment.centerRight,
                        color: Colors.red,
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      child: ListTile(
                        title: Text(todo.title),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(todo.description),
                            Text(todo.date.formattedDate),
                          ],
                        ),
                      ),
                    );
                  });
            }
            return const SizedBox.shrink();
          }),
    );
  }
}
