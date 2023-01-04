import '../model/to_do_model.dart';

abstract class HomeRepository {
  Future<List<ToDoModel>> getToDos(String userId);
}
