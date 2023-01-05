import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/to_do_model.dart';

class AddToDoRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<bool> addTodo(ToDoModel toDoModel) async {
    try {
      final result =
          await _firestore.collection('ToDoList').add(toDoModel.toMap());
      return result.id.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<void> updateTodo(ToDoModel toDoModel) async {
    try {
      await _firestore
          .collection('ToDoList')
          .doc(toDoModel.id)
          .set(toDoModel.toMap());
    } catch (e) {
      rethrow;
    }
  }
}
