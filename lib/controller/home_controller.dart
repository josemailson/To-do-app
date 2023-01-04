import 'package:flutter/material.dart';

import '../repository/home_repository.dart';
import '../repository/sign_in_repository.dart';
import '../view/home/home_state.dart';

class HomeController {
  final AuthRepository _repository;
  final HomeRepository _homeRepository;
  HomeController(this._repository, this._homeRepository);
  final notifier = ValueNotifier<HomeState>(HomeInitialState());
  HomeState get state => notifier.value;

  Future<void> signOut() async {
    await _repository.signOut();
    notifier.value = HomeLogoutState();
  }

  Future<void> getToDos() async {
    notifier.value = HomeLoadingState();
    try {
      final userId = _repository.currentUser?.uid;
      final result = await _homeRepository.getToDos(userId ?? '');
      notifier.value = HomeSuccessState(result);
    } catch (e) {
      notifier.value = HomeErrorState();
    }
  }
}
