import 'package:firebase_auth/firebase_auth.dart';
import 'package:mocktail/mocktail.dart';
import 'package:to_do_app/controller/sign_in_controller.dart';
import 'package:to_do_app/repository/sign_in_repository.dart';

class AuthRepositoryMock extends Mock implements AuthRepository {}

class SignInControllerMock extends Mock implements SignInController {}

class FirebaseMock extends Mock implements FirebaseAuth {}

class UserCredentialMock extends Mock implements UserCredential {}

class UserMock extends Mock implements User {}
