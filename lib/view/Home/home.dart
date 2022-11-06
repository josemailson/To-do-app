import 'package:flutter/material.dart';
import 'package:to_do_app/controller/home_controller.dart';
import 'package:to_do_app/model/to_do_model.dart';
import 'package:to_do_app/repository/home_repository.dart';

import '../add/add_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isDone = false;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final homeController = HomeController(HomeRepositoryHttp());
  final controller = HomeController(HomeRepositoryHttp());

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do List'),
        actions: [
          IconButton(
              onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddPage())).then((_) {
                    setState(() {});
                  }),
              icon: const Icon(Icons.add))
        ],
      ),
      body: FutureBuilder<List<ToDoModel>>(
        future: controller.getToDos(),
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
                      value: isDone,
                      onChanged: (bool? value) {
                        setState(() {
                          isDone = value!;
                        });
                      }),
                  title: Text(todo?.title ?? ''),
                  subtitle: Text(todo?.description ?? ''),
                  trailing: const Icon(Icons.delete),
                );
              });
        }),
      ),
    );
  }
}
