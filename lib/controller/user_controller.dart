import 'package:flutter/material.dart';
import 'package:to_do_app/repository/sign_in_repository.dart';
import 'package:to_do_app/repository/user_repository.dart';
import 'package:to_do_app/view/home/home_state.dart';

import '../model/to_do_model.dart';

class UserController {
  final Repository _repository;
  final UserRepository _userRepository;
  UserController(this._repository, this._userRepository);
  final notifier = ValueNotifier<HomeState>(HomeInitialState());
  HomeState get state => notifier.value;

  Future<void> signOut() async {
    await _repository.signOut();
    notifier.value = HomeLogoutState();
  }

  Future<List<ToDoModel>> getToDos() async {
    final userId = _repository.currentUser?.uid;
    final result = await _userRepository.getToDos(userId ?? '');
    throw (result);
  }
}
