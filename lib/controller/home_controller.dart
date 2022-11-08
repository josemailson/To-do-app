import '../model/to_do_model.dart';
import '../repository/home_repository.dart';

class HomeController {
  final HomeRepository homeRepository;

  HomeController(this.homeRepository);

  Future<bool> createToDo(ToDoModel toDoModel) async {
    final result = await homeRepository.createToDo(toDoModel);
    return result;
  }

  Future<List<ToDoModel>> getToDos() async {
    final result = await homeRepository.getToDos();
    return result;
  }

  Future<bool> deleteToDo(String id) async {
    return await homeRepository.deleteToDo(id);
  }

  Future<bool> editToDo(String id, ToDoModel toDo) async {
    return await homeRepository.editToDo(id, toDo);
  }
}
