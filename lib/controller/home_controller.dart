import '../model/to_do_model.dart';
import '../repository/home_repository.dart';

class HomeController {
  final HomeRepository homeRepository;

  HomeController(this.homeRepository);

  Future<void> createToDo(ToDoModel toDoModel) async {
    final result = await homeRepository.createToDo(toDoModel);
    print(result);
  }

  Future<List<ToDoModel>> getToDos() async {
    final result = await homeRepository.getToDos();
    return result;
  }
}
