import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/to_do_model.dart';

abstract class HomeRepository {
  Future<bool> createToDo(ToDoModel toDoModel);
  Future<List<ToDoModel>> getToDos();
  Future<bool> deleteToDo(String id);
  Future<bool> checkToDo(String id, ToDoModel toDo);
}

class HomeRepositoryHttp implements HomeRepository {
  final baseUrl = 'https://crudcrud.com/api/a4605c24ac9741f9954e6782d7bbc859';
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

  @override
  Future<bool> deleteToDo(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/todos/$id'),
    );
    return response.statusCode == 200;
  }

  @override
  Future<bool> checkToDo(String id, ToDoModel toDo) async {
    final response = await http.put(Uri.parse('$baseUrl/todos/$id'),
        body: toDo.toJson(),
        headers: {
          "content-type": "application/json",
          "accept": "application/json"
        });
    return response.statusCode == 200;
  }
}
