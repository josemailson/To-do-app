import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/to_do_model.dart';
import 'home_repository.dart';

class HomeFirebaseRepository implements HomeRepository {
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<List<ToDoModel>> getToDos(String userId) async {
    final result = await _firestore
        .collection("ToDoList")
        .where("userId", isEqualTo: userId)
        .get();
    final todoList = List<ToDoModel>.from(
        result.docs.map((doc) => ToDoModel.fromMap(doc.id, doc.data())));
    return todoList;
  }
}
