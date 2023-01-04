// import 'package:flutter/material.dart';

// import '../../controller/home_controller.dart';
// import '../../model/to_do_model.dart';
// import '../../repository/home_repository.dart';

// class EditPage extends StatefulWidget {
//   final String id;
//   final bool isDone;
//   final String title;
//   final String description;
//   const EditPage(
//       {super.key,
//       required this.id,
//       required this.isDone,
//       required this.title,
//       required this.description});

//   @override
//   State<EditPage> createState() => _EditPageState();
// }

// class _EditPageState extends State<EditPage> {
//   late TextEditingController titleController = TextEditingController();
//   late TextEditingController descriptionController = TextEditingController();
//   final homeController = HomeController(HomeRepositoryHttp());
//   final controller = HomeController(HomeRepositoryHttp());

//   @override
//   Widget build(BuildContext context) {
//     titleController = TextEditingController(text: widget.title);
//     descriptionController = TextEditingController(text: widget.description);
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Editar'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//               child: Column(
//             children: [
//               TextFormField(
//                 controller: titleController,
//                 decoration: const InputDecoration(hintText: 'Título'),
//               ),
//               TextFormField(
//                 controller: descriptionController,
//                 decoration: const InputDecoration(hintText: 'Descrição'),
//               ),
//               ElevatedButton(
//                   onPressed: () {
//                     homeController.editToDo(
//                         widget.id,
//                         ToDoModel(
//                             title: titleController.text,
//                             description: descriptionController.text,
//                             isDone: widget.isDone,
//                             date: DateTime.now(),
//                             userId: ''));
//                     Navigator.pop(context, true);
//                   },
//                   child: const Text('Editar'))
//             ],
//           )),
//         ));
//   }
// }
