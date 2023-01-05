import 'package:flutter/material.dart';

import '../model/to_do_model.dart';
import '../repository/add_repository.dart';
import '../repository/sign_in_repository.dart';
import '../view/add/add_state.dart';

class AddToDoController {
  final AuthRepository _authRepository;
  final AddToDoRepository _addTodoRepository;
  final notifier = ValueNotifier<AddToDoState>(AddToDoInitialState());

  AddToDoState get state => notifier.value;

  AddToDoController(this._authRepository, this._addTodoRepository);

  Future<void> addToDo(String title, String description) async {
    try {
      final userId = _authRepository.currentUser?.uid ?? '';
      final todoModel = ToDoModel(
        userId: userId,
        date: DateTime.now(),
        title: title,
        description: description,
        isDone: false,
      );
      if (await _addTodoRepository.addTodo(todoModel)) {
        notifier.value = AddToDoSuccessState();
      }
      throw Exception();
    } catch (e) {
      notifier.value = AddToDoErrorState();
    }
  }

  Future<void> updateTodo(
      ToDoModel toDoModel, String title, String description) async {
    try {
      final toDoModelRequest = ToDoModel(
        id: toDoModel.id,
        userId: toDoModel.userId,
        date: toDoModel.date,
        title: title,
        description: description,
        isDone: toDoModel.isDone,
      );
      await _addTodoRepository.updateTodo(toDoModelRequest);
      notifier.value = AddToDoSuccessState();
    } catch (e) {
      notifier.value = AddToDoErrorState();
    }
  }
}
