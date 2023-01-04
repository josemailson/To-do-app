import '../../model/to_do_model.dart';

abstract class HomeState {}

class HomeInitialState implements HomeState {}

class HomeLogoutState implements HomeState {}

class HomeLoadingState implements HomeState {}

class HomeSuccessState implements HomeState {
  final List<ToDoModel> todoList;

  HomeSuccessState(this.todoList);
}

class HomeErrorState implements HomeState {}
