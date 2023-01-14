import 'package:flutter/material.dart';

import '../model/to_do_model.dart';
import '../repository/add_repository.dart';
import '../repository/sign_in_repository.dart';
import '../view/add/add_state.dart';

class AddToDoController {
  final AuthRepository _authRepository;
  final AddToDoRepository _addToDoRepository;
  final notifier = ValueNotifier<AddToDoState>(AddToDoInitialState());

  AddToDoState get state => notifier.value;

  AddToDoController(this._authRepository, this._addToDoRepository);

  Future<void> addToDo(String title, String description) async {
    try {
      final userId = _authRepository.currentUser?.uid ?? '';
      final toDoModel = ToDoModel(
        userId: userId,
        date: DateTime.now(),
        title: title,
        description: description,
        isDone: false,
      );
      if (await _addToDoRepository.addToDo(toDoModel)) {
        notifier.value = AddToDoSuccessState();
      }
      throw Exception();
    } catch (e) {
      notifier.value = AddToDoErrorState();
    }
  }

  Future<void> updateToDo(ToDoModel toDoModel, String title, String description,
      bool isDone) async {
    try {
      final toDoModelRequest = ToDoModel(
        id: toDoModel.id,
        userId: toDoModel.userId,
        date: toDoModel.date,
        title: title,
        description: description,
        isDone: isDone,
      );
      await _addToDoRepository.updateToDo(toDoModelRequest);
      notifier.value = AddToDoSuccessState();
    } catch (e) {
      notifier.value = AddToDoErrorState();
    }
  }
}
