import '../model/to_do_model.dart';

abstract class UserRepository {
  Future<List<ToDoModel>> getToDos(String userId);
}
