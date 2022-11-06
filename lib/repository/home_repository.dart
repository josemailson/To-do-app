import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/to_do_model.dart';

abstract class HomeRepository {
  Future<bool> createToDo(ToDoModel toDoModel);
  Future<List<ToDoModel>> getToDos();
}

class HomeRepositoryHttp implements HomeRepository {
  final baseUrl = 'https://crudcrud.com/api/4995b690dc0942fe8ede5afead3a4ce2';
  @override
  Future<bool> createToDo(ToDoModel toDoModel) async {
    final response = await http.post(Uri.parse('$baseUrl/todos'),
        body: toDoModel.toJson(),
        headers: {
          "content-type": "application/json",
          "accept": "application/json"
        });
    return true;
  }

  @override
  Future<List<ToDoModel>> getToDos() async {
    final response = await http.get(
      Uri.parse('$baseUrl/todos'),
    );
    final list = List.from(jsonDecode(response.body));
    final toDos = list.map((e) => ToDoModel.fromMap(e)).toList();
    return toDos;
  }
}
