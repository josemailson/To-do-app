import 'package:get_it/get_it.dart';
import 'package:to_do_app/repository/sign_in_repository.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<Repository>(FirebaseRepository());
}
