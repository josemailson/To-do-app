import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/model/to_do_model.dart';
import 'package:to_do_app/repository/user_repository.dart';

class HomeFirebaseRepository implements UserRepository {
  final _firestore = FirebaseFirestore.instance;
  @override
  Future<bool> createToDo(ToDoModel toDoModel) {
    // TODO: implement createToDo
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteToDo(String id) {
    // TODO: implement deleteToDo
    throw UnimplementedError();
  }

  @override
  Future<bool> editToDo(String id, ToDoModel toDo) {
    // TODO: implement editToDo
    throw UnimplementedError();
  }

  @override
  Future<List<ToDoModel>> getToDos(String userId) async {
    final result = await _firestore
        .collection("ToDoList")
        .where("userId", isEqualTo: userId)
        .get();
    print(result);
    return [];
  }
}
