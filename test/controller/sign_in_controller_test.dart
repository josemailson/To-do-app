import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:to_do_app/controller/sign_in_controller.dart';
import 'package:to_do_app/repository/sign_in_repository.dart';
import 'package:to_do_app/view/sign_in/sign_in_state.dart';

import '../mock/mock_classes.dart';

void main() {
  late FirebaseRepository repository;
  late SignInController signInController;
  late FirebaseMock firebaseAuth;
  late UserCredentialMock userCredential;
  late UserMock user;

  setUp(() {
    firebaseAuth = FirebaseMock();
    repository = FirebaseRepository(firebaseAuth);
    signInController = SignInController(repository);
    userCredential = UserCredentialMock();
    user = UserMock();
  });
  group('sign in controller login', () {
    test('login controller success state', () async {
      expect(signInController.state, isInstanceOf<InitialSignInState>());
      when(
        () => firebaseAuth.signInWithEmailAndPassword(
            email: 'user@email.com', password: 'user@123'),
      ).thenAnswer((invocation) async => userCredential);
      when((() => userCredential.user)).thenReturn(user);
      await signInController.login('user@email.com', 'user@123');
      expect(signInController.state, isInstanceOf<SuccessSignInState>());
    });
    test('login controller no user returned, throw exception', () async {
      expect(signInController.state, isInstanceOf<InitialSignInState>());
      when(
        () => firebaseAuth.signInWithEmailAndPassword(
            email: 'user@email.com', password: 'user@123'),
      ).thenAnswer((invocation) async => userCredential);
      await signInController.login('user@email.com', 'user@123');
      expect(signInController.state, isInstanceOf<ErrorSignInState>());
    });

    test('no connection, throw exception controller', () async {
      expect(signInController.state, isInstanceOf<InitialSignInState>());
      when(
        () => firebaseAuth.signInWithEmailAndPassword(
            email: 'user@email.com', password: 'user@123'),
      ).thenThrow(Exception());
      await signInController.login('user@email.com', 'user@123');
      expect(signInController.state, isInstanceOf<ErrorSignInState>());
    });
  });

  group('sign controller register method', () {
    test('register controller success state', () async {
      expect(signInController.state, isInstanceOf<InitialSignInState>());
      when(
        () => firebaseAuth.createUserWithEmailAndPassword(
            email: 'user@email.com', password: 'user@123'),
      ).thenAnswer((invocation) async => userCredential);
      when((() => userCredential.user)).thenReturn(user);
      await signInController.register('user@email.com', 'user@123');
      expect(signInController.state, isInstanceOf<SuccessSignInState>());
    });
    test('register controller error state', () async {
      expect(signInController.state, isInstanceOf<InitialSignInState>());
      when(
        () => firebaseAuth.createUserWithEmailAndPassword(
            email: 'user@email.com', password: 'user@123'),
      ).thenThrow(Exception());
      await signInController.register('user@email.com', 'user@123');
      expect(signInController.state, isInstanceOf<ErrorSignInState>());
    });
  });
}
